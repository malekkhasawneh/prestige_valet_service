import 'package:prestige_valet_app/features/valet/data/datasource/valet_remote_datasource.dart';
import 'package:prestige_valet_app/features/valet/data/repository/valet_repository_impl.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/car_delivered_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/change_park_status_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_valet_history_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/park_car_usecase.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> valetInjection() async {
  // Cubit
  sl.registerFactory(
    () => ScanQrCubit(
        parkCarUseCase: sl(),
        changeParkStatusUseCase: sl(),
        carDeliveredUseCase: sl(),
        getValetHistoryUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => ParkCarUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangeParkStatusUseCase(repository: sl()));
  sl.registerLazySingleton(() => CarDeliveredUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetValetHistoryUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<ValetRepository>(
    () => ValetRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ValetRemoteDataSource>(
    () => ValetRemoteDataSourceImpl(),
  );
}
