import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';

class PlayerOverlay extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  const PlayerOverlay({
    super.key,
    required this.isLoading,
    this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    log("PlayerOverlay: isLoading: $isLoading Error: $error");
    if (isLoading) {
      return Container(
        color: context.colorScheme.background.withOpacity(0.5),
        child: const Center(child: LoadingIndicatorWidget()),
      );
    }

    if (error != null && error!.isNotEmpty) {
      return Container(
        color: context.colorScheme.background.withOpacity(0.8),
        alignment: Alignment.center,
        child: ErrorFeedbackWidget(errorMessage: error!, onRetry: onRetry),
      );
    }

    return const SizedBox.shrink();
  }
}
