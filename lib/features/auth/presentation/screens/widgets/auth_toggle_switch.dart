import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/utils/get_responsive_size.dart';

class AuthToggleSwitch extends StatelessWidget {
  final bool isLogin;
  const AuthToggleSwitch({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.isDesktop ? 48 : 48.h,
      padding: EdgeInsets.all(context.isDesktop ? 4 : 4.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(context.isDesktop ? 12 : 12.r),
      ),
      child: Row(
        children: [
          _buildTab(context, "login", isActive: isLogin),
          _buildTab(context, "register", isActive: !isLogin),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, {required bool isActive}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isActive) {
            if (label == "login") {
              context.go(AppRoutes.loginScreen);
            } else {
              context.go(AppRoutes.registerScreen);
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? context.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(context.isDesktop ? 8 : 8.r),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Text(
            context.tr(label),
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w500,
              color: isActive
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}