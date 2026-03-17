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
  Future<Either<String, List<PackagesModel>>> getAllPackages({
    int? page,
    int? pageSize,
  }) async {
    return await apiConsumer.get<List<PackagesModel>>(
      EndPoint.allPackages,
      queryParameters: {'page': page, 'page_size': pageSize},
      fromJson: (json) => PackagesResponseModel.fromJson(json).data,
    );
  }

  @override
  Future<Either<String, PackagesModel>> getPackageBySlug(String slug) {
    // Implementation for fetching a package by its slug
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<PackagesModel>>> searchInPackages(String query) {
    // Implementation for searching packages
    throw UnimplementedError();
  }
}

