part of 'package_details_bloc.dart';

sealed class PackageDetailsEvent extends Equatable {
  const PackageDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetpackagesEventBySlug extends PackageDetailsEvent {
  final String slug;
  const GetpackagesEventBySlug({required this.slug});

  @override
  List<Object> get props => [slug];
}
