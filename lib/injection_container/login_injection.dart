import 'package:prestige_valet_app/features/login/data/datasource/login_local_datasource.dart';
import 'package:prestige_valet_app/features/login/data/datasource/login_remote_datasource.dart';
import 'package:prestige_valet_app/features/login/data/repository/user_repository_impl.dart';
import 'package:prestige_valet_app/features/login/domain/repository/login_repository.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_with_google_usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/set_login_flag_usecase.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> loginInjection() async {
  // Cubit
  sl.registerFactory(
    () => LoginCubit(
        loginUseCase: sl(),
        loginWithGoogleUseCase: sl(),
        setLoginFlagUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetLoginFlagUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(),
  );
}