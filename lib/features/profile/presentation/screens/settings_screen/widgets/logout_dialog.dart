import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.r),
      ),
      title: Text(
        context.tr('logout'),
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colorScheme.onSurface,
        ),
      ),
      content: Text(
        context.tr('logout_confirmation'),
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            context.tr('cancel'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            context.read<ProfileBloc>().add(LogoutEvent());
          },
          child: Text(
            context.tr('logout'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
