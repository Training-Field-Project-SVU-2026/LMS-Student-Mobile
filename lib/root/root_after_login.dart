import 'package:flutter/material.dart';
import 'package:lms_student/features/explore/presentation/screens/explore_screen.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen_after_login.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/settings_screen.dart';
import 'package:lms_student/features/my_courses/presentation/screens/my_courses_screen.dart';

import 'package:lms_student/root/custom_nav_bar.dart';

class RootAfterLogin extends StatefulWidget {
  const RootAfterLogin({super.key});

  @override
  State<RootAfterLogin> createState() => _RootAfterLoginState();
}

class _RootAfterLoginState extends State<RootAfterLogin> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreenAfterLogin(),
    const ExploreScreen(),
    const MyCoursesScreenAfterLogin(),
    const SettingsScreen(),

  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });

    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: changePage,
      ),
    );
  }
}
