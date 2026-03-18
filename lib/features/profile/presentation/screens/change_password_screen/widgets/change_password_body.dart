import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('Your new password must be different from your previous password.'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  _buildLabel(context, 'Old Password'),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: _oldPasswordController,
                    hintText: 'Enter old password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      return null;
                    },
                  ),

                  SizedBox(height: 24.h),

                  _buildLabel(context, 'New Password'),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: _newPasswordController,
                    hintText: 'Enter new password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 24.h),

                  _buildLabel(context, 'Confirm New Password'),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Re-type new password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 48.h),

                  CustomPrimaryButton(
                    text: isLoading ? 'Saving...' : 'Save Password',
                    width: double.infinity,
                    onTap: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
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

  Widget _buildLabel(BuildContext context, String label) {
    return Text(
      label,
      style: context.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}