// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'packages_model_bloc.dart';

sealed class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class Packagesloading extends PackageState {}

class Packagesloaded extends PackageState {
  final List<PackagesModel> package;
  const Packagesloaded({required this.package});
  @override
  List<Object> get props => [package];
}

class Packageserror extends PackageState {
  final String message;
  const Packageserror({required this.message});
  @override
  List<Object> get props => [message];
}
