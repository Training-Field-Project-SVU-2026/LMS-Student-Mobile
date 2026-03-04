import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/di/service_locator.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:lms_student/features/auth/presentation/screens/register_screen/register_screen.dart';
import 'package:lms_student/test_screen.dart';

class RouterGenerator {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/test',
    routes: [
      // for test 
      GoRoute(
        path: '/test', 
        name: 'test_widgets',
        builder: (context, state) => const TestScreen(),
      ),
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text("Splash Screen"))),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.registerScreen,
        name: AppRoutes.registerScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => Container(),
      ),
      // GoRoute(
      //   path: AppRoutes.loginScreen,
      //   name: AppRoutes.loginScreen,
      //   builder: (context, state) {
      //     return BlocProvider(
      //       create: (context) => sl<AuthCubit>(),
      //       child: LoginScreen(),
      //     );
      //   },
      // ),
    ],
  );
}
