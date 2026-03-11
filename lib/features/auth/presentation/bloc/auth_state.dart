part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess<T> extends AuthState {
  final T? data;
  AuthSuccess({this.data});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class ForgetPasswordEmailSent extends AuthState {}

class ResendSuccess extends AuthState {
  final String message;
  ResendSuccess(this.message);
}
