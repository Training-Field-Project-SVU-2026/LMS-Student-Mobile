import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_state.dart';
import '../../data/model/packages_model.dart';

class PackagePaginatedUIModel extends PaginatedUIModel<PackagesModel> {
  final List<PackagesModel> packages;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalPackages;

  PackagePaginatedUIModel({
    required this.packages,
    required this.totalPages,
    required this.currentPage,
    required this.totalPackages,
  }) : super(
          items: packages,
          totalPages: totalPages,
          currentPage: currentPage,
        );

  @override
  PackagePaginatedUIModel copyWithItems(
    List<PackagesModel> newItems, {
    int? totalPages,
    int? currentPage,
    int? totalPackages,
  }) {
    return PackagePaginatedUIModel(
      packages: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalPackages: totalPackages ?? this.totalPackages,
    );
  }
}
