import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class LanguageDialog extends StatelessWidget {
  final String selectedLanguageCode;
  final ValueChanged<String> onLanguageSelected;

  const LanguageDialog({
    super.key,
    required this.selectedLanguageCode,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.r),
      ),
      title: Text(
        context.tr('language'),
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colorScheme.onSurface,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              context.tr('english'),
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: selectedLanguageCode == 'en' ? FontWeight.bold : FontWeight.normal,
                color: selectedLanguageCode == 'en' ? context.colorScheme.primary : context.colorScheme.onSurface,
              ),
            ),
            onTap: () {
              onLanguageSelected('en');
              context.pop();
            },
            trailing: selectedLanguageCode == 'en'
                ? Icon(Icons.check, color: context.colorScheme.primary)
                : null,
          ),
          ListTile(
            title: Text(
              context.tr('arabic'),
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: selectedLanguageCode == 'ar' ? FontWeight.bold : FontWeight.normal,
                color: selectedLanguageCode == 'ar' ? context.colorScheme.primary : context.colorScheme.onSurface,
              ),
            ),
            onTap: () {
              onLanguageSelected('ar');
              context.pop();
            },
            trailing: selectedLanguageCode == 'ar'
                ? Icon(Icons.check, color: context.colorScheme.primary)
                : null,
          ),
        ],
      ),
    );
  }
}
