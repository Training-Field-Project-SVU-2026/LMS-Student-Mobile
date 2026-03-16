// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';
import 'package:lms_student/features/explore/domain/repositories/explore_repository.dart';

part 'packages_model_event.dart';
part 'packages_model_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final ExploreRepository exploreRepository;

  PackageBloc({required this.exploreRepository}) : super(PackageInitial()) {
    on<Getallpackage>((event, emit) async {
      emit(Packagesloading());

      try {
        final response = await exploreRepository.getAllPackages();
        response.fold(
          (packages) => emit(Packagesloaded(package: packages)),
          (error) => emit(Packageserror(message: error)),
        );
      } catch (e) {
        emit(Packageserror(message: e.toString()));
      }
    });
  }
}
