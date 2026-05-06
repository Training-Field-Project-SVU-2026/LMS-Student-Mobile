import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:lms_student/features/explore/presentation/bloc/explore_event.dart';
import 'package:lms_student/features/explore/presentation/bloc/explore_state.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custom_category.dart';
import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';

class ViewAllPackages extends StatefulWidget {
  const ViewAllPackages({super.key});

  @override
  State<ViewAllPackages> createState() => _ViewAllPackagesState();
}

class _ViewAllPackagesState extends State<ViewAllPackages> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(const GetpackagesEvent(page: 1));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<ExploreBloc>().state;
      if (state.packageStatus == ExploreStatus.success &&
          !state.isPackagePaginationLoading &&
          (state.packageUIModel?.currentPage ?? 0) <
              (state.packageUIModel?.totalPages ?? 0)) {
        context.read<ExploreBloc>().add(
          GetpackagesEvent(
            page: (state.packageUIModel?.currentPage ?? 0) + 1,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('learning_tracks'),
          style: context.textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state.packageStatus == ExploreStatus.loading) {
            return const LoadingIndicatorWidget();
          }
          if (state.packageStatus == ExploreStatus.failure) {
            return ErrorFeedbackWidget(
              errorMessage: state.packageError ?? 'Error',
              onRetry: () {
                context.read<ExploreBloc>().add(const GetpackagesEvent(page: 1));
              },
            );
          }
          if (state.packageStatus == ExploreStatus.success) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ExploreBloc>().add(const GetpackagesEvent(page: 1));
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: state.packages.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.packages.length) {
                    final package = state.packages[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomCategory(
                        title: package.title,
                        description: package.description,
                        courses: package.coursesCount,
                        price: package.price,
                        category: package.categories,
                        slug: package.slug,
                      ),
                    );
                  } else {
                    return state.isPackagePaginationLoading
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
