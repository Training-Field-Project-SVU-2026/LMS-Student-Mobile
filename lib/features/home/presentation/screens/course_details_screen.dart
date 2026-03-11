// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('course_details'))),
      body: Center(child: Text(context.tr('this_is_course_details_screen'))),
    );
  }
}
