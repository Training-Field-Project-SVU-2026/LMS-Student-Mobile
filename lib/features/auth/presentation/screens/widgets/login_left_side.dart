import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/theme/app_assets.dart';
import 'package:lms_student/core/utils/get_responsive_size.dart';

class LoginLeftSide extends StatelessWidget {
  const LoginLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.primary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            context.tr('commit_ma3ana'),
                            style: context.textTheme.titleMedium!.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                borderRadius: BorderRadius.circular(24.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: context.colorScheme.onSecondary
                                        .withValues(alpha: 0.2),
                                    blurRadius: 30.r,
                                    offset: Offset(0, 15.h),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(24),
                              child: Image.asset(
                                AppAssets.authLeftSidePng,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 48.h),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: context.textTheme.headlineMedium!
                                    .copyWith(
                                      color: context.colorScheme.onPrimary,
                                      fontWeight: FontWeight.w900,
                                      height: 1.2,
                                    ),
                                children: [
                                  TextSpan(
                                    text: "${context.tr('commit_today')}\n",
                                  ),
                                  TextSpan(
                                    text: context.tr('build_your_future'),
                                    style: TextStyle(
                                      color: context.colorScheme.secondary,
                                      fontSize: context.isDesktop ? 24 : 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              context.tr('join_learners_desc'),
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colorScheme.onPrimary.withValues(
                                  alpha: 0.7,
                                ),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: Wrap(
                        spacing: 32,
                        runSpacing: 16,
                        children: [
                          _buildBottomLink(
                            context,
                            context.tr('learn_by_doing'),
                          ),
                          _buildBottomLink(
                            context,
                            context.tr('track_progress'),
                          ),
                          _buildBottomLink(context, context.tr('grow_daily')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomLink(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.labelMedium!.copyWith(
        color: context.colorScheme.onPrimary.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
