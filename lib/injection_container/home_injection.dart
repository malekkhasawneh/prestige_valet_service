import 'package:prestige_valet_app/features/home/data/datasource/home_local_datasource.dart';
import 'package:prestige_valet_app/features/home/data/repository/home_repository_impl.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_data_usecase.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> homeInjection() async {
  // Cubit
  sl.registerFactory(
    () => HomeCubit(getUserDataUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserDataUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: sl()),
  );

  // Data sources

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
}
