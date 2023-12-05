import 'package:prestige_valet_app/features/bottom_navigation_bar/data/datasource/nav_remote_datasouce.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/repository/nav_repository_impl.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/add_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/get_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/update_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> bottomNavInjection() async {
  // Cubit
  sl.registerFactory(
    () => BottomNavBarCubit(
        getNotificationTokenUseCase: sl(),
        updateNotificationTokenUseCase: sl(),
        addNotificationTokenUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotificationTokenUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => UpdateNotificationTokenUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddNotificationTokenUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<NavRepository>(
    () => NavRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources

  sl.registerLazySingleton<NavRemoteDataSource>(
    () => NavRemoteDataSourceImpl(),
  );
}
