part of 'auth_bloc.dart';

abstract class AuthEvent {}

// before switch to mixin
// class RegisterEvent extends AuthEvent {
//   final RegisterRequestModel request;
//   RegisterEvent({required this.request});
// }

class RegisterEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {}

class ForgetPasswordEvent extends AuthEvent {}

class ClearFormEvent extends AuthEvent {}
