import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/features/auth/data/model/reset_password_request_model.dart';
import 'package:lms_student/features/auth/data/model/verify_email_request_model.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';
import 'package:lms_student/features/auth/presentation/bloc/form_controller_mixin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with FormControllersMixin {
  final AuthRepository authRepository;
  final CacheHelper? cacheHelper;

  AuthBloc({required this.authRepository, this.cacheHelper})
    : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ClearFormEvent>(_onClearForm);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<ResendOtpEvent>(_onResendOtp);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    if (!validateLoginForm()) {
      emit(AuthError(message: 'Please fill all fields correctly'));
      return;
    }

    emit(AuthLoading());

    final request = getLoginRequest();
    final result = await authRepository.login(request);

    result.fold(
      (errorMessage) {
        emit(AuthError(message: errorMessage));
      },
      (successResponse) {
        if (successResponse.user.role == 'student') {
          clearLoginControllers();
          emit(AuthSuccess(data: successResponse));
        } else {
          emit(AuthError(message: 'You are not authorized to login'));
        }
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    if (!validateRegisterForm()) {
      emit(AuthError(message: 'Please fill all fields correctly'));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      emit(AuthError(message: 'Passwords do not match'));
      return;
    }
    emit(AuthLoading());

    final request = getRegisterRequest();
    final result = await authRepository.register(request);

    result.fold(
      (errorMessage) {
        emit(AuthError(message: errorMessage));
      },
      (successResponse) {
        // clearRegisterControllers();
        emit(AuthSuccess(data: successResponse));
      },
    );
  }

  Future<void> _onVerifyEmail(
    VerifyEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (!validateOtpForm()) {
      emit(AuthError(message: 'Please enter OTP code'));
      return;
    }

    emit(AuthLoading());

    final request = VerifyEmailRequestModel(email: event.email, otp: event.otp);

    final result = await authRepository.verifyEmail(request);

    result.fold((error) => emit(AuthError(message: error)), (successMessage) {
      clearOtpControllers();
      emit(AuthSuccess(data: successMessage));
    });
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.resendOtp(event.email);

    result.fold(
      (error) => emit(AuthError(message: error)),
      (successMessage) => emit(ResendSuccess(successMessage)),
    );
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.forgotPassword(event.email);

    result.fold(
      (error) => emit(AuthError(message: error)),
      (successMessage) => emit(ForgotPasswordSuccess(successMessage)),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.resetPassword(event.requestModel);

    result.fold(
      (error) => emit(AuthError(message: error)),
      (successMessage) => emit(AuthSuccess(data: successMessage)),
    );
  }

  void _onClearForm(ClearFormEvent event, Emitter<AuthState> emit) {
    clearRegisterControllers();
    clearLoginControllers();
  }

  @override
  Future<void> close() {
    disposeControllers();
    return super.close();
  }
}
