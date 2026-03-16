import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    // this will change when we get the user data from the API
    final String? imageUrl =
        'https://i.pinimg.com/originals/e4/75/e8/e475e8c67c567f8a7d9ebe267666694d.gif';

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        context.pushNamed(AppRoutes.studentProfileScreen);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: context.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.outline.withValues(alpha: 0.2),
                  ),
                  child: ClipOval(
                    child:
                        imageUrl != null
                            ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (context, url, error) => Icon(
                                    Icons.person,
                                    size: 30.r,
                                    color: context.colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.5),
                                  ),
                            )
                            : Icon(
                              Icons.person,
                              size: 30.r,
                              color: context.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.5),
                            ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 12.w,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    /// TODO: Get user name from API
                    'Alex Johnson',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Text(
                    /// TODO: Get user email from API
                    'alex.j@skillup.com',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
