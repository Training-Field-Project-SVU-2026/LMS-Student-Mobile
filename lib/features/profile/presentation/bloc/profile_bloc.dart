import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/data/model/user_model.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/profile/data/model/change_password_model.dart';
import 'package:lms_student/features/profile/data/model/logout_request_model.dart';
import 'package:lms_student/features/profile/domain/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final CacheHelper cacheHelper;

  ProfileBloc({required this.profileRepository, required this.cacheHelper})
    : super(ProfileInitial()) {
    on<LogoutEvent>(_onLogout);
    on<ChangePasswordEvent>(_onChangePassword);
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    final refreshToken =
        cacheHelper.getData(key: ApiKey.refreshToken) as String?;

    if (refreshToken == null) {
      await cacheHelper.clearUserData();

      emit(LogoutSuccess());
      return;
    }

    final request = LogoutRequestModel(refresh: refreshToken);

    final result = await profileRepository.logout(request);

    result.fold(
      (error) => emit(ProfileError(message: error)),
      (data) => emit(LogoutSuccess()),
    );
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final result = await profileRepository.changePassword(event.request);

    result.fold(
      (error) => emit(ProfileError(message: error)),
      (response) => emit(ChangePasswordSuccess(changePasswordModel: response)),
    );
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    // 1. Try to get data from cache first
    final userJson = cacheHelper.getData(key: ApiKey.user) as String?;
    if (userJson != null && userJson.isNotEmpty) {
      try {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        final user = UserModel.fromJson(userData);
        emit(GetProfileSuccess(user: user));
        // Optionally we could still fetch from API to refresh,
        // but if the API returns 403 we should probably just stick to cache.
        log(userJson);
        return;
      } catch (e) {
        // If decoding fails, continue to API call
      }
    }

    // 2. If no cache or if we want to refresh, call API
    final slug = cacheHelper.getData(key: ApiKey.slug) as String?;

    if (slug == null || slug.isEmpty) {
      emit(ProfileError(message: 'User slug not found'));
      return;
    }

    final result = await profileRepository.getProfile(slug);

    result.fold(
      (error) => emit(ProfileError(message: error)),
      (user) => emit(GetProfileSuccess(user: user)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final slug = cacheHelper.getData(key: ApiKey.slug) as String?;
    if (slug == null || slug.isEmpty) {
      emit(ProfileError(message: 'User slug not found'));
      return;
    }

    final result = await profileRepository.updateProfile(
      slug: slug,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
    );

    result.fold((error) => emit(ProfileError(message: error)), (user) async {
      // تحديث الـ Cache
      await cacheHelper.saveData(key: ApiKey.firstName, value: user.firstName);
      await cacheHelper.saveData(key: ApiKey.lastName, value: user.lastName);
      await cacheHelper.saveData(key: ApiKey.email, value: user.email);
      await cacheHelper.saveData(key: ApiKey.image, value: user.image);

      // تحديث الـ JSON
      final userJson = jsonEncode(user.toJson());
      await cacheHelper.saveData(key: ApiKey.user, value: userJson);

      emit(GetProfileSuccess(user: user));
    });
  }
}
