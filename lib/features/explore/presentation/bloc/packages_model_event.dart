part of 'packages_model_bloc.dart';

sealed class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class Getallpackage extends PackageEvent {}
