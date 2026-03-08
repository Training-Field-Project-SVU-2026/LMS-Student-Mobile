// import 'package:flutter/material.dart';
// import 'package:lms_student/features/explore/presentation/explore_screen_befor_login.dart';
// import 'package:lms_student/features/home/presentation/screens/home_screen.dart';
// import 'package:lms_student/features/home/presentation/screens/home_screen_after_login.dart';
// import 'package:lms_student/root/custom_nav_bar.dart';
// import 'package:lms_student/test_screen.dart';

// class Root extends StatefulWidget {
//   const Root({super.key});

//   @override
//   State<Root> createState() => _RootState();
// }

// class _RootState extends State<Root> {
//   PageController controller = PageController();
//   int currentIndex = 0;

//   List<Widget> screens = [
//     HomeScreen(),
//     ExploreScreenBeforLogin(),
//     HomeScreenAfterLogin(),
//     TestScreen(),
//   ];

//   void changePage(int index) {
//     setState(() {
//       currentIndex = index;
//     });

//     controller.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: controller,
//         physics: const NeverScrollableScrollPhysics(),
//         children: screens,
//       ),

//       bottomNavigationBar: CustomNavBar(
//         currentIndex: currentIndex,
//         onTap: changePage,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/explore/presentation/explore_screen_befor_login.dart';
import 'package:lms_student/features/home/data/repositories/home_repository_impl.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen_after_login.dart';
import 'package:lms_student/root/custom_nav_bar.dart';
import 'package:lms_student/test_screen.dart';

// 👇 استيرادات مهمة للـ BLoC والـ Repository
import 'package:lms_student/features/home/presentation/bloc/courses_bloc.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    ExploreScreenBeforLogin(),
    HomeScreenAfterLogin(),
    TestScreen(),
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
    // 👇 هنا هنلف الـ Scaffold كله بـ MultiProvider
    return MultiProvider(
      providers: [
        // 1️⃣ الأول: نجهز الـ Dio (لو مش عاملها في مكان تاني)
        Provider<Dio>(create: (_) => Dio()),

        // 2️⃣ تاني حاجة: ApiConsumer
        Provider<ApiConsumer>(
          create: (context) => DioConsumer(dio: context.read<Dio>()),
        ),

        // 3️⃣ تالت حاجة: HomeRepository
        Provider<HomeRepository>(
          create: (context) =>
              HomeRepositoryImpl(apiConsumer: context.read<ApiConsumer>()),
        ),

        // 4️⃣ رابع حاجة: CoursesBloc (اللي محتاجينه)
        BlocProvider<CoursesBloc>(
          create: (context) =>
              CoursesBloc(homeRepository: context.read<HomeRepository>()),
        ),
      ],
      child: Scaffold(
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndex: currentIndex,
          onTap: changePage,
        ),
      ),
    );
  }
}
