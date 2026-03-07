import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/extensions/context_extensions.dart';

class AuthToggleSwitch extends StatelessWidget {
  final bool isLogin;
  const AuthToggleSwitch({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(

        color: context.colorScheme.outline.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          _buildTab(context, "Login", isActive: isLogin),
          _buildTab(context, "Register", isActive: !isLogin),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, {required bool isActive}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? context.colorScheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isActive ? [
            BoxShadow(color: context.colorScheme.onSecondary.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
          ] : null,
        ),
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: isActive ? context.colorScheme.primary : context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}