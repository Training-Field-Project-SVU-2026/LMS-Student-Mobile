part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {}

class ForgetPasswordEvent extends AuthEvent {}

class ClearFormEvent extends AuthEvent {}

// wanna understand why 
class VerifyEmailEvent extends AuthEvent {
 final String email;  
  final String otp;
  
  VerifyEmailEvent({
    required this.email,
    required this.otp,
  });
}

class ResendOtpEvent extends AuthEvent {
  final String email;

  ResendOtpEvent({required this.email});
}

