import 'package:dartz/dartz.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';

abstract class PackageRepository {
  Future<Either<List<PackagesModel>, String>> getAllPackages({
    int? page,
    int? pageSize,
  });
  Future<Either<PackagesModel, String>> getPackageBySlug(String slug);
  Future<Either<List<PackagesModel>, String>> searchInPackages(String query);
}
