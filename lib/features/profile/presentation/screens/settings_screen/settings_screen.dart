import 'package:flutter/material.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/settings_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: const SettingsBody(),
    );
  }
}
