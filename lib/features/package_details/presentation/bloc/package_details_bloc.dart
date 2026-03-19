import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_student/core/common_logic/domain/repositories/package_repository.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';

part 'package_details_event.dart';
part 'package_details_state.dart';

class PackageDetailsBloc
    extends Bloc<PackageDetailsEvent, PackageDetailsState> {
  final PackageRepository packageRepository;
  PackageDetailsBloc({required this.packageRepository})
    : super(PackageDetailsInitial()) {
    on<GetpackagesEventBySlug>((event, emit) async {
      emit(PackageDetailsLoading());
      try {
        final result = await packageRepository.getPackageBySlug(event.slug);
        result.fold(
          (error) {
            emit(PackageDetailsError(message: error));
          },
          (packages) {
            emit(PackageDetailsLoaded(packagesModel: packages));
          },
        );
      } catch (e) {
        emit(PackageDetailsError(message: e.toString()));
      }
    });
  }
}
