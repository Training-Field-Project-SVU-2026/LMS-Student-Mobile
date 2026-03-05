import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/routing/router_generator.dart';
import 'package:lms_student/core/di/service_locator.dart';
import 'package:lms_student/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          supportedLocales: const [Locale('en'), Locale('ar')],
          locale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'LMS Student',
          theme: AppTheme.lightTheme,
          routerConfig: RouterGenerator.goRouter,
        );
      },
    );
  }
}
