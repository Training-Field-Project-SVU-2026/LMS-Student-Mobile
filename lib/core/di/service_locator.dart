import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/dio_consumer.dart';
import 'package:lms_student/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/explore/data/repository/explore_repository_imp.dart';
import 'package:lms_student/features/explore/domain/repositories/explore_repository.dart';
import 'package:lms_student/features/explore/presentation/bloc/packages_model_bloc.dart';
import 'package:lms_student/features/common/data/repositories/course_repository_impl.dart';
import 'package:lms_student/features/common/domain/repositories/course_repository.dart';
import 'package:lms_student/features/home/data/repositories/home_repository_impl.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';
import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';
import 'package:lms_student/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:lms_student/features/splash/domain/splash_repository.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  sl.registerLazySingleton<CacheHelper>(() => cacheHelper);

  // External
  sl.registerLazySingleton(() => Dio());

  // Remote package
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  // Features - Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiConsumer: sl(), cacheHelper: sl()),
  );
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  // Features - Course
  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(apiConsumer: sl()),
  );

  // Features - Home
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiConsumer: sl()),
  );
  sl.registerFactory(
    () => HomeBloc(courseRepository: sl(), homeRepository: sl()),
  );

  // Splash - Login
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(apiConsumer: sl(), cacheHelper: sl()),
  );
  sl.registerFactory(() => SplashBloc(splashRepository: sl()));

  // Features - Explore
  sl.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImp(apiConsumer: sl()),
  );

  // register factory for PackageBloc
  sl.registerFactory(
    () => PackageBloc(exploreRepository: sl<ExploreRepository>()),
  );
}
