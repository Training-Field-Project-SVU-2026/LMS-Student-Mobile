import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/domain/repositories/package_repository.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';
import 'package:lms_student/features/explore/data/model/packages_response_model.dart';

class PackageRepositoryImpl implements PackageRepository {
  final ApiConsumer apiConsumer;
  PackageRepositoryImpl({required this.apiConsumer});
  @override
  Future<Either<List<PackagesModel>, String>> getAllPackages({
    int? page,
    int? pageSize,
  }) async {
    try {
      final responseData = await apiConsumer.get(
        EndPoint.allPackages,
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      final response = PackagesResponseModel.fromJson(responseData);

      if (response.success &&
          (response.status == 200 || response.status == 201)) {
        return Left(response.data);
      } else {
        return Right(response.message);
      }
    } catch (e) {
      if (e is String) {
        return Right(e);
      }
      return Right('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Either<PackagesModel, String>> getPackageBySlug(String slug) {
    // Implementation for fetching a package by its slug
    throw UnimplementedError();
  }

  @override
  Future<Either<List<PackagesModel>, String>> searchInPackages(String query) {
    // Implementation for searching packages
    throw UnimplementedError();
  }
}
