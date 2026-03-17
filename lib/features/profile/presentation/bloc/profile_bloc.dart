import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/profile/data/model/logout_request_model.dart';
import 'package:lms_student/features/profile/domain/repositories/profile_repository.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final CacheHelper cacheHelper;

  ProfileBloc({
    required this.profileRepository,
    required this.cacheHelper,
  }) : super(ProfileInitial()) {
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    final refreshToken = cacheHelper.getData(key: ApiKey.refreshToken) as String?;

    if (refreshToken == null) {
      await cacheHelper.removeData(key: ApiKey.accessToken);
      await cacheHelper.removeData(key: ApiKey.refreshToken);
      await cacheHelper.removeData(key: ApiKey.user);
      await cacheHelper.removeData(key: ApiKey.isLoggedIn);

      emit(LogoutSuccess());
      return;
    }

    final request = LogoutRequestModel(refresh: refreshToken);

    try {
      await profileRepository.logout(request);
      emit(LogoutSuccess());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}