import 'dart:developer';

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
import 'package:lms_student/features/course/presentation/bloc/coursedetails_bloc.dart';
import 'package:lms_student/features/course/presentation/screens/course_after_enroll.dart';
import 'package:lms_student/features/course/presentation/screens/view_all_course.dart';
import 'package:lms_student/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:lms_student/features/package_details/presentation/bloc/package_details_bloc.dart';
import 'package:lms_student/features/package_details/presentation/screens/package_details.dart';
import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';
import 'package:lms_student/features/home/presentation/screens/home_screen_before_login.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_event.dart';
import 'package:lms_student/features/course/presentation/screens/course_details_screen.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/presentation/screens/change_password_screen/change_password_screen.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/settings_screen.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/student_profile_screen.dart';
import 'package:lms_student/features/splash/presentation/screens/splash_screen.dart';
import 'package:lms_student/root/root_after_login.dart';
import 'package:lms_student/root/root_before_login.dart';

class RouterGenerator {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<SplashBloc>()..add(SplashStarted()),
            child: const SplashScreen(),
          );
        },
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
        path: AppRoutes.settingsScreen,
        name: AppRoutes.settingsScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<ProfileBloc>(),
            child: const SettingsScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.studentProfileScreen,
        name: AppRoutes.studentProfileScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<ProfileBloc>()..add(GetProfileEvent()),
            child: const StudentProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.changePasswordScreen,
        name: AppRoutes.changePasswordScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<ProfileBloc>(),
            child: const ChangePasswordScreen(),
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
            create: (context) => sl<HomeBloc>(),
            child: HomeScreenBeforeLogin(),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.packageDetails,
        name: AppRoutes.packageDetails,
        builder: (context, state) {
          final slug = state.extra as String;
          log('Route received slug: $slug');
          return BlocProvider(
            create: (context) => sl<PackageDetailsBloc>(),
            child: PackageDetails(slug: slug),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.courseDetailsScreen,
        name: AppRoutes.courseDetailsScreen,
        builder: (context, state) {
          String? slug;
          bool isenroll = false;

          if (state.extra is Map<String, dynamic>) {
            final extraMap = state.extra as Map<String, dynamic>;
            slug = extraMap['slug'] as String?;
            isenroll = extraMap['isEnrolled'] as bool? ?? false;
          } else if (state.extra is String) {
            slug = state.extra as String;
          }

          log('Route received slug: $slug');

          return BlocProvider(
            create: (context) => sl<CoursedetailsBloc>(),
            child: CourseDetailsScreen(slug: slug, isenroll: isenroll),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.courseAfterEnroll,
        name: AppRoutes.courseAfterEnroll,
        builder: (context, state) {
          final slug = state.extra as String?;
          log('Route received slug: $slug');

          return BlocProvider(
            create: (context) => sl<CoursedetailsBloc>(),
            child: CourseAfterEnroll(slug: slug),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.viewAllCourse,
        name: AppRoutes.viewAllCourse,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => sl<HomeBloc>(),
            child: ViewAllCourse(),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.rootAfterLogin,
        name: AppRoutes.rootAfterLogin,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<HomeBloc>()),
              BlocProvider(create: (context) => sl<ExploreBloc>()),
              BlocProvider.value(value: sl<ProfileBloc>()),
            ],
            child: const RootAfterLogin(),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.rootBeforeLogin,
        name: AppRoutes.rootBeforeLogin,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<HomeBloc>()),
              BlocProvider(create: (context) => sl<ExploreBloc>()),
            ],
            child: const RootBeforeLogin(),
          );
        },
      ),
    ],
  );
}
