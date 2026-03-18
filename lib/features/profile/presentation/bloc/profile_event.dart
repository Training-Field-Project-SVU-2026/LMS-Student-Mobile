part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class ChangePasswordEvent extends ProfileEvent {
  final ChangePasswordModel request;

  ChangePasswordEvent({required this.request});
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;

  UpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}