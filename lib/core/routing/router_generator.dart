import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/di/service_locator.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/presentation/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:lms_student/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:lms_student/features/auth/presentation/screens/register_screen/register_screen.dart';
import 'package:lms_student/features/auth/presentation/screens/reset_password_screen/reset_password_screen.dart';
import 'package:lms_student/features/auth/presentation/screens/verify_otp_screen/verify_otp_screen.dart';
import 'package:lms_student/features/explore/presentation/explore_screen_befor_login.dart';
import 'package:lms_student/features/home/presentation/bloc/courses_bloc.dart';
import 'package:lms_student/features/home/presentation/screens/course_details_screen.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen.dart';
import 'package:lms_student/features/splash/presentation/screens/splash_screen.dart';
import 'package:lms_student/root/root.dart';

class RouterGenerator {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.verifyOtpScreen,
        name: AppRoutes.verifyOtpScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] ?? '';

          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: VerifyOtpScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordScreen,
        name: AppRoutes.forgotPasswordScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const ForgotPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPasswordScreen,
        name: AppRoutes.resetPasswordScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] ?? '';
          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: ResetPasswordScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.registerScreen,
        name: AppRoutes.registerScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<CoursesBloc>(),
            child: const Root(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.course_details_screen,
        name: AppRoutes.course_details_screen,
        builder: (context, state) {
          return CourseDetailsScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.homeScreenAfterLogin,
        name: AppRoutes.homeScreenAfterLogin,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [BlocProvider(create: (context) => sl<CoursesBloc>())],
            child: const Root(),
          );
        },
      ),
    ],
  );
}
