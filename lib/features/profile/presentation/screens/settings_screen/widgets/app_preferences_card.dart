import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/data/model/language_model.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/language_selector_sheet.dart';

class AppPreferencesCard extends StatefulWidget {
  const AppPreferencesCard({super.key});

  @override
  State<AppPreferencesCard> createState() => _AppPreferencesCardState();
}

class _AppPreferencesCardState extends State<AppPreferencesCard> {
  bool _emailNotifications = true;
  bool _isDarkMode = false;

  final List<Language> _languages = const [
    Language('English (US)', 'en'),
    Language('العربية', 'ar'),
  ];

  Language _selectedLanguage = const Language('English (US)', 'en');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 24.h),
          _buildLanguageSelector(context),
          SizedBox(height: 20.h),
          _buildThemeToggle(context),
          SizedBox(height: 24.h),
          _buildNotificationToggle(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.settings_outlined, color: context.colorScheme.secondary),
        SizedBox(width: 8.w),
        Text(
          'App Preferences',
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interface Language',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: () => LanguageSelectorSheet.show(
            context: context,
            languages: _languages,
            selectedLanguage: _selectedLanguage,
            onLanguageSelected: (lang) =>
                setState(() => _selectedLanguage = lang),
          ),
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedLanguage.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interface Theme',
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text('Dark Mode', style: context.textTheme.bodySmall),
            ],
          ),
        ),
        CupertinoSwitch(
          value: _isDarkMode,
          activeColor: context.colorScheme.primary,
          onChanged: (val) => setState(() => _isDarkMode = val),
        ),
      ],
    );
  }

  Widget _buildNotificationToggle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email Notifications',
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Updates about new courses and features',
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        CupertinoSwitch(
          value: _emailNotifications,
          activeColor: context.colorScheme.primary,
          onChanged: (val) => setState(() => _emailNotifications = val),
        ),
      ],
    );
  }
}
