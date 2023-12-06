import 'package:prestige_valet_app/features/bottom_navigation_bar/data/datasource/nav_local_datasource.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/datasource/nav_remote_datasouce.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/repository/nav_repository_impl.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/add_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/get_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/must_reset_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/update_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> bottomNavInjection() async {
  // Cubit
  sl.registerFactory(
        () => BottomNavBarCubit(
        getNotificationTokenUseCase: sl(),
        updateNotificationTokenUseCase: sl(),
        addNotificationTokenUseCase: sl(),
        mustResetNotificationTokenUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotificationTokenUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => UpdateNotificationTokenUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddNotificationTokenUseCase(repository: sl()));
  sl.registerLazySingleton(() => MustResetNotificationTokenUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<NavRepository>(
    () => NavRepositoryImpl(
        remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<NavLocalDataSource>(
    () => NavLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<NavRemoteDataSource>(
    () => NavRemoteDataSourceImpl(localDataSource: sl()),
  );
}
