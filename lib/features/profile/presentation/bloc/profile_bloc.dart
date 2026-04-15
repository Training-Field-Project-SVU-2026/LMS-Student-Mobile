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
    on<ClearProfileDataEvent>(_onClearProfileData);
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(LogoutLoading());

    final refreshToken =
        cacheHelper.getData(key: ApiKey.refreshToken) as String?;

    if (refreshToken == null) {
      await cacheHelper.clearUserData();
      emit(LogoutSuccess());
      return;
    }

    final request = LogoutRequestModel(refresh: refreshToken);

    final result = await profileRepository.logout(request);

    result.fold((error) => emit(ProfileError(message: error)), (data) {
      emit(LogoutSuccess());
      add(ClearProfileDataEvent());
    });
  }

  Future<void> _onClearProfileData(
    ClearProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileInitial());
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

    final userJson = cacheHelper.getData(key: ApiKey.user) as String?;

    if (userJson != null && userJson.isNotEmpty) {
      try {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        final user = UserModel.fromJson(userData);
        emit(GetProfileSuccess(user: user));
        return;
      } catch (e) {
        // complete if an error occurs
      }
    }

    final slug = cacheHelper.getData(key: ApiKey.slug) as String?;
    if (slug == null || slug.isEmpty) {
      emit(ProfileError(message: 'User slug not found'));
      return;
    }

    log('Token: ${cacheHelper.getData(key: ApiKey.accessToken)}');
    log('Slug from cache: ${cacheHelper.getData(key: ApiKey.slug)}');
    log('Email from cache: ${cacheHelper.getData(key: ApiKey.email)}');
    final result = await profileRepository.getProfile(slug);

    await result.fold((error) async => emit(ProfileError(message: error)), (
      user,
    ) async {
      final updatedUserJson = jsonEncode(user.toJson());
      await cacheHelper.saveData(key: ApiKey.user, value: updatedUserJson);
      await cacheHelper.saveData(key: ApiKey.firstName, value: user.firstName);
      await cacheHelper.saveData(key: ApiKey.lastName, value: user.lastName);
      await cacheHelper.saveData(key: ApiKey.email, value: user.email);
      await cacheHelper.saveData(key: ApiKey.image, value: user.image);

      emit(GetProfileSuccess(user: user));
    });
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

    log('Token: ${cacheHelper.getData(key: ApiKey.accessToken)}');
    log('Slug from cache: ${cacheHelper.getData(key: ApiKey.slug)}');

    final result = await profileRepository.updateProfile(
      slug: slug,
      firstName: event.firstName,
      lastName: event.lastName,
    );

    await result.fold((error) async => emit(ProfileError(message: error)), (
      updatedUser,
    ) async {

      final email = cacheHelper.getData(key: ApiKey.email) as String? ?? '';
      final slugFromCache =
          cacheHelper.getData(key: ApiKey.slug) as String? ?? '';
      final imageFromCache = cacheHelper.getData(key: ApiKey.image) as String?;


      final mergedUser = UserModel(
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        email: email,
        slug: updatedUser.slug.isNotEmpty ? updatedUser.slug : slugFromCache,
        image: updatedUser.image ?? imageFromCache,
        role: updatedUser.role,
        isActive: updatedUser.isActive,
        isVerified: updatedUser.isVerified,
      );

      await cacheHelper.saveData(
        key: ApiKey.user,
        value: jsonEncode(mergedUser.toJson()),
      );
      await cacheHelper.saveData(
        key: ApiKey.firstName,
        value: mergedUser.firstName,
      );
      await cacheHelper.saveData(
        key: ApiKey.lastName,
        value: mergedUser.lastName,
      );

      emit(GetProfileSuccess(user: mergedUser));
    });
  }
}
