import 'package:dartz/dartz.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';
import 'package:lms_student/features/explore/data/model/packages_response_model.dart';
import 'package:lms_student/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImp implements ExploreRepository {
  final ApiConsumer apiConsumer;
  ExploreRepositoryImp({required this.apiConsumer});
  @override
  Future<Either<List<PackagesModel>, String>> getAllPackages() async {
    try {
      final responseData = await apiConsumer.get(EndPoint.allPackages);
      final response = Packagesresponsemodel.fromJson(responseData);

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
