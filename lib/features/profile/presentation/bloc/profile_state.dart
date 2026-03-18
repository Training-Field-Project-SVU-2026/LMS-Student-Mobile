part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class LogoutSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}

class ChangePasswordSuccess extends ProfileState {
  final ChangePasswordModel changePasswordModel;
  ChangePasswordSuccess({required this.changePasswordModel});
}

class GetProfileSuccess extends ProfileState {
  final UserModel user;
  GetProfileSuccess({required this.user});
}
