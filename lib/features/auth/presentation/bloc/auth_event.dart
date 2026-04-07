part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {}

class ClearFormEvent extends AuthEvent {}

class VerifyEmailEvent extends AuthEvent {
  final String email;
  final String otp;

  VerifyEmailEvent({required this.email, required this.otp});
}

class ResendOtpEvent extends AuthEvent {
  final String email;

  ResendOtpEvent({required this.email});
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordRequestModel requestModel;

  ResetPasswordEvent({required this.requestModel});

}
