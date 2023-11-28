import 'package:prestige_valet_app/features/pick_up/data/datasource/pick_up_remote_datasource.dart';
import 'package:prestige_valet_app/features/pick_up/data/repository/pick_up_repository_impl.dart';
import 'package:prestige_valet_app/features/pick_up/domain/repository/pick_up_repository.dart';
import 'package:prestige_valet_app/features/pick_up/domain/usecase/get_gates_usecase.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> pickUpInjection() async {
  // Cubit
  sl.registerFactory(
    () => PickUpCubit(getGatesUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetGatesUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PickUpRepository>(
    () => PickUpRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PickUpRemoteDataSource>(
    () => PickUpRemoteDataSourceImpl(),
  );
}
