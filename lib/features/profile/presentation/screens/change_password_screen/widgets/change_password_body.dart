import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/auth/utils/auth_validation.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/data/model/change_password_model.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Password changed successfully'),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.pop();
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final isLoading = state is ProfileLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: SizedBox(
                      width: 120.r,
                      height: 120.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 120.r,
                            height: 120.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  context.colorScheme.tertiaryContainer,
                                  context.colorScheme.primaryContainer
                                      .withValues(alpha: 0.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          Container(
                            width: 80.r,
                            height: 80.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  context.colorScheme.tertiary,
                                  context.colorScheme.primary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: context.colorScheme.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.lock_rounded,
                              size: 40.r,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          Positioned(
                            bottom: 10.r,
                            right: 15.r,
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: context.colorScheme.shadow
                                        .withValues(alpha: 0.1),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.verified_user_rounded,
                                size: 22.r,
                                color: context.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    context.tr(
                      'Your new password must be different from your previous password.',
                    ),
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: context.colorScheme.outline.withValues(
                          alpha: 0.1,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withValues(
                            alpha: 0.05,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(
                          context,
                          'Old Password',
                          Icons.lock_outline,
                        ),
                        SizedBox(height: 12.h),
                        CustomTextFormField(
                          controller: _oldPasswordController,
                          hintText: 'Enter old password',
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        _buildLabel(
                          context,
                          'New Password',
                          Icons.key_outlined,
                        ),
                        SizedBox(height: 12.h),
                        CustomTextFormField(
                          controller: _newPasswordController,
                          hintText: 'Enter new password',
                          isPassword: true,
                          validator: (value) {
                            //TODO: we have to put the folder of utils in auth in the common folder ya قائد
                           return validatePassword(value);
                          },
                        ),
                        SizedBox(height: 24.h),
                        _buildLabel(
                          context,
                          'Confirm New Password',
                          Icons.done_all_outlined,
                        ),
                        SizedBox(height: 12.h),
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          hintText: 'Re-type new password',
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (value != _newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomPrimaryButton(
                    text: isLoading ? 'Saving...' : 'Save Password',
                    width: double.infinity,
                    onTap: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<ProfileBloc>().add(
                                ChangePasswordEvent(
                                  request: ChangePasswordModel(
                                    oldPassword: _oldPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                  ),
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.r,
          color: context.colorScheme.primary.withValues(alpha: 0.8),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
