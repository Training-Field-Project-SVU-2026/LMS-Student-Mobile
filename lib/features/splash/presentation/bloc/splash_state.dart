import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {}

class SplashError extends SplashState {
  final String? message;
  final bool? isActive;
  final bool? isVerified;

  const SplashError({this.message, this.isActive, this.isVerified});

  @override
  List<Object?> get props => [message, isActive, isVerified];
}