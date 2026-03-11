import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/explore/presentation/explore_screen_befor_login.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen_after_login.dart';
import 'package:lms_student/root/custom_nav_bar.dart';
import 'package:lms_student/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:lms_student/features/auth/presentation/screens/register_screen/register_screen.dart';

import 'package:lms_student/features/home/presentation/bloc/courses_bloc.dart';
import 'package:lms_student/core/di/service_locator.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreenAfterLogin(),
    ExploreScreenBeforLogin(),
    HomeScreenAfterLogin(),
    RegisterScreen(),
    LoginScreen(),
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
