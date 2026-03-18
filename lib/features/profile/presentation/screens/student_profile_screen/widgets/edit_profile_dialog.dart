import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class EditProfileDialog extends StatefulWidget {
  final String initialFirstName;
  final String initialLastName;
  final String initialEmail;

  const EditProfileDialog({
    super.key,
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialEmail,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialFirstName);
    _lastNameController = TextEditingController(text: widget.initialLastName);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Profile',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.close,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'First Name',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  'Last Name',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  'Email Address',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                CustomPrimaryButton(
                  text: 'Save Changes',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ProfileBloc>().add(
                        UpdateProfileEvent(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                        ),
                      );
                      context.pop(); // نقفل الـ Dialog
                    }
                  },
                ),
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    'Cancel',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
