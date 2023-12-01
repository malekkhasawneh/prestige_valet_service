import 'package:prestige_valet_app/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:prestige_valet_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:prestige_valet_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:prestige_valet_app/features/profile/domain/repository/profile_repository.dart';
import 'package:prestige_valet_app/features/profile/domain/usecase/clear_cache_usecase.dart';
import 'package:prestige_valet_app/features/profile/domain/usecase/logout_usecase.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> profileInjection() async {
  // Cubit
  sl.registerFactory(
    () => ProfileCubit(logoutUseCase: sl(), clearCacheUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => ClearCacheUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );
}
