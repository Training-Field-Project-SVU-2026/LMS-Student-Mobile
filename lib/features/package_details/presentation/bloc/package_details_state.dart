// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables
part of 'package_details_bloc.dart';

sealed class PackageDetailsState extends Equatable {
  const PackageDetailsState();

  @override
  List<Object> get props => [];
}

class PackageDetailsInitial extends PackageDetailsState {}

class PackageDetailsLoading extends PackageDetailsState {}

class PackageDetailsLoaded extends PackageDetailsState {
  final PackagesModel packagesModel;
  PackageDetailsLoaded({required this.packagesModel});
}

class PackageDetailsError extends PackageDetailsState {
  final String message;
  PackageDetailsError({required this.message});
}
