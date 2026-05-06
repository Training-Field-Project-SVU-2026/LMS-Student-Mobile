import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/data/model/course/response_package_byslug_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/package_repository.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/core/utils/api_query_params.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';
import 'package:lms_student/features/explore/data/model/packages_response_model.dart';
import 'package:lms_student/features/explore/domain/entity/package_paginated_ui_model.dart';

class PackageRepositoryImpl implements PackageRepository {
  final ApiConsumer apiConsumer;
  PackageRepositoryImpl({required this.apiConsumer});
  @override
  Future<Either<String, PackagePaginatedUIModel>> getAllPackages({
    int? page,
    int? pageSize,
  }) async {
    final result = await apiConsumer.get<PackagesResponseModel>(
      EndPoint.allPackages,
      queryParameters: ApiQueryParams.pagination(
        page: page ?? 1,
        pageSize: pageSize ?? 10,
      ),
      fromJson: (json) => PackagesResponseModel.fromJson(json),
    );

    return result.fold(
      (error) => Left(error),
      (model) => Right(
        PackagePaginatedUIModel(
          packages: model.data,
          totalPages: model.totalPages ?? 0,
          currentPage: model.currentPage ?? 0,
          totalPackages: model.totalPackages ?? 0,
        ),
      ),
    );
  }

  @override
  Future<Either<String, PackagesModel>> getPackageBySlug(String slug) async {
    return await apiConsumer.get<PackagesModel>(
      "${EndPoint.packagesBySlug}$slug/",
      fromJson: (json) => PackageBySlugResponseModel.fromJson(json).data,
    );
  }

  @override
  Future<Either<String, List<PackagesModel>>> searchInPackages(String query) {
    // Implementation for searching packages
    throw UnimplementedError();
  }
}
