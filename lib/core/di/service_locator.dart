import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/dio_consumer.dart';
import 'package:lms_student/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';

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
  sl.registerFactory(() => AuthBloc(authRepository: sl()/*,cacheHelper: sl()*/));
}
