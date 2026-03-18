import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/splash/domain/splash_repository.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_event.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository splashRepository;

  SplashBloc({required this.splashRepository}) : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    final result = await splashRepository.checkLogin();
    result.fold(
      (error) => emit(SplashError(message: error)),
      (checkAuthDataModel) {
        if (checkAuthDataModel.isActive != null &&
            checkAuthDataModel.isVerified != null &&
            checkAuthDataModel.isActive! &&
            checkAuthDataModel.isVerified!) {
          emit(SplashLoaded());
        } else {
          emit(SplashError(
            isActive: checkAuthDataModel.isActive,
            isVerified: checkAuthDataModel.isVerified,
          ));
        }
      },
    );

  }
}
