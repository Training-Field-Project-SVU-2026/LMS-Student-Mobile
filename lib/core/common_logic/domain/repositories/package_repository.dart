import 'package:dartz/dartz.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';

abstract class PackageRepository {
  Future<Either<String, List<PackagesModel>>> getAllPackages({
    int? page,
    int? pageSize,
  });
  Future<Either<String, PackagesModel>> getPackageBySlug(String slug);
  Future<Either<String, List<PackagesModel>>> searchInPackages(String query);
}

