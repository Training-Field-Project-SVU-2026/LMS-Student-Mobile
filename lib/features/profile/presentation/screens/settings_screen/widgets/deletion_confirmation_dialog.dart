import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class DeletionConfirmationDialog extends StatefulWidget {
  const DeletionConfirmationDialog({super.key});

  @override
  State<DeletionConfirmationDialog> createState() =>
      _DeletionConfirmationDialogState();
}

class _DeletionConfirmationDialogState
    extends State<DeletionConfirmationDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isConfirmEnabled = false;
  final String _safetyWord = 'DELETE';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: context.colorScheme.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: context.colorScheme.error,
                    size: 24.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Delete Account?',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'This action is irreversible. You will permanently lose access to:',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            _buildWarningItem(context, 'All enrolled courses and progress'),
            _buildWarningItem(context, 'Earned certificates and achievements'),
            _buildWarningItem(context, 'Account profile and settings'),
            SizedBox(height: 24.h),
            Text(
              'To confirm, please type "$_safetyWord" below:',
              style: context.textTheme.bodySmall,
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              hintText: 'Type $_safetyWord here',
              controller: _controller,
              width: double.infinity,
              onChanged: (value) {
                setState(() {
                  _isConfirmEnabled = value.trim() == _safetyWord;
                });
              },
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      'Cancel',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomPrimaryButton(
                    text: 'Confirm Delete',
                    width: double.infinity,
                    onTap: _isConfirmEnabled
                        ? () {
                            // TODO: Implement actual deletion logic
                            context.pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Account Deletion Initiated'),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.error,
                      foregroundColor: context.colorScheme.onError,
                      disabledBackgroundColor: context.colorScheme.error
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: 6.w,
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          SizedBox(width: 8.w),
          Expanded(child: Text(text, style: context.textTheme.bodySmall)),
        ],
      ),
    );
  }
}
