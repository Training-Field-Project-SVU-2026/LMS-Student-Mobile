import 'package:flutter/material.dart';
import 'package:lms_student/features/explore/presentation/explore_screen_befor_login.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen_before_login.dart';
import 'package:lms_student/root/custom_nav_bar.dart';

class RootBeforeLogin extends StatefulWidget {
  const RootBeforeLogin({super.key});

  @override
  State<RootBeforeLogin> createState() => _RootBeforeLoginState();
}

class _RootBeforeLoginState extends State<RootBeforeLogin> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreenBeforeLogin(),
    ExploreScreenBeforLogin(),
    const SizedBox(), //MyCoursesScreenBeforeLogin(),
    const SizedBox(), //ProfileScreenBeforeLogin(),
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
