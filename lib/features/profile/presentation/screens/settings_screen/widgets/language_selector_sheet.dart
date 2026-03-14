import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/data/model/language_model.dart';

class LanguageSelectorSheet extends StatelessWidget {
  final List<Language> languages;
  final Language selectedLanguage;
  final ValueChanged<Language> onLanguageSelected;

  const LanguageSelectorSheet({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  static Future<void> show({
    required BuildContext context,
    required List<Language> languages,
    required Language selectedLanguage,
    required ValueChanged<Language> onLanguageSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return LanguageSelectorSheet(
          languages: languages,
          selectedLanguage: selectedLanguage,
          onLanguageSelected: onLanguageSelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Language',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languages.length,
            separatorBuilder: (context, index) => Divider(
              color: context.colorScheme.outline.withValues(alpha: 0.2),
            ),
            itemBuilder: (context, index) {
              final lang = languages[index];
              final isSelected = selectedLanguage.code == lang.code;
              return InkWell(
                    onTap: () {
                      onLanguageSelected(lang);
                      context.pop();
                    },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lang.name,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: context.colorScheme.primary,
                          size: 20.w,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
