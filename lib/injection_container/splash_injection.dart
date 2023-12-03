import 'package:prestige_valet_app/features/splash/data/datasource/splash_local_datasource.dart';
import 'package:prestige_valet_app/features/splash/data/repository/splash_repository_impl.dart';
import 'package:prestige_valet_app/features/splash/domain/repository/splash_repository.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/check_is_user_login_usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/get_is_first_time_usecae.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/is_user_usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/set_is_first_time_usecase.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> splashInjection() async {
  // Cubit
  sl.registerFactory(
        () => SplashCubit(
        checkIsUserLoginUseCase: sl(),
        setIsFirstTimeOpenTheAppUseCase: sl(),
        getIsFirstTimeOpenTheAppUseCase: sl(),
        isUserUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckIsUserLoginUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => SetIsFirstTimeOpenTheAppUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetIsFirstTimeOpenTheAppUseCase(repository: sl()));
  sl.registerLazySingleton(() => IsUserUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(),
  );
}
