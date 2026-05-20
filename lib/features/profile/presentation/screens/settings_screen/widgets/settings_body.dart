import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/theme/theme_cubit.dart';
import 'package:lms_student/core/localization/locale_cubit.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/settings_section.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/setting_tile.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/language_dialog.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/logout_dialog.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final selectedLanguageCode = context
        .watch<LocaleCubit>()
        .state
        .languageCode;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go(AppRoutes.loginScreen);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('settings'),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colorScheme.onSurface,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 32.h),

              SettingsSection(
                title: context.tr('account'),
                items: [
                  SettingsTile(
                    icon: Icons.person_outline_rounded,
                    title: context.tr('profile'),
                    subtitle: context.tr('manage_profile_desc'),
                    onTap: () {
                      context.pushNamed(AppRoutes.studentProfileScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              SettingsSection(
                title: context.tr('appearance'),
                items: [
                  SettingsTile(
                    icon: Icons.dark_mode_outlined,
                    title: context.tr('dark_mode'),
                    subtitle: context.tr('dark_mode_desc'),
                    iconColor: context.colorScheme.onSurfaceVariant,
                    trailing: Switch(
                      value: isDarkMode,
                      activeColor: context.colorScheme.primary,
                      onChanged: (val) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              SettingsSection(
                title: context.tr('language'),
                items: [
                  SettingsTile(
                    icon: Icons.language_outlined,
                    title: context.tr('language'),
                    subtitle: selectedLanguageCode == 'en'
                        ? context.tr('english')
                        : context.tr('arabic'),
                    iconColor: context.colorScheme.secondary,
                    onTap: () => showDialog(
                      context: context,
                      builder: (dialogContext) => LanguageDialog(
                        selectedLanguageCode: selectedLanguageCode,
                        onLanguageSelected: (code) {
                          context.read<LocaleCubit>().changeLocale(code);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              SettingsSection(
                title: context.tr('security'),
                items: [
                  SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    title: context.tr('change_password'),
                    subtitle: context.tr('update_security_desc'),
                    iconColor: context.colorScheme.onSurface,
                    onTap: () {
                      context.pushNamed(AppRoutes.changePasswordScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              SettingsSection(
                title: context.tr('system'),
                items: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      final isLogoutLoading = state is LogoutLoading;

                      return SettingsTile(
                        icon: Icons.logout_outlined,
                        title: isLogoutLoading
                            ? context.tr('signing_out')
                            : context.tr('sign_out'),
                        subtitle: context.tr('sign_out_desc'),
                        titleColor: context.colorScheme.error,
                        iconColor: context.colorScheme.error,
                        onTap: isLogoutLoading
                            ? null
                            : () => showDialog(
                                context: context,
                                builder: (dialogContext) => BlocProvider.value(
                                  value: context.read<ProfileBloc>(),
                                  child: const LogoutDialog(),
                                ),
                              ),
                      );
                    },
                  ),
                  // Divider(
                  //   height: 1,
                  //   thickness: 1,
                  //   color: context.colorScheme.onSurface.withValues(alpha: 0.05),
                  //   indent: 20.w,
                  //   endIndent: 20.w,
                  // ),
                  // SettingsTile(
                  //   icon: Icons.delete_outline_rounded,
                  //   title: context.tr('delete_account'),
                  //   subtitle: context.tr('delete_account_desc'),
                  //   titleColor: context.colorScheme.error,
                  //   iconColor: context.colorScheme.error,
                  //   onTap: () => showDialog(
                  //     context: context,
                  //     builder: (context) => const DeletionConfirmationDialog(),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
