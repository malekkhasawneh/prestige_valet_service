import 'package:prestige_valet_app/features/valet/data/datasource/valet_remote_datasource.dart';
import 'package:prestige_valet_app/features/valet/data/repository/valet_repository_impl.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/car_delivered_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/change_park_status_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_cars_queue_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_guest_price_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_slot_number_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_valet_history_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_valet_parking_types_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/park_car_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/set_car_status_as_retrieving_usecase.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> valetInjection() async {
  // Cubit
  sl.registerFactory(
    () => ScanQrCubit(
        parkCarUseCase: sl(),
        changeParkStatusUseCase: sl(),
        carDeliveredUseCase: sl(),
      getValetHistoryUseCase: sl(),
      getSlotNumberUseCase: sl(),
      getCarsQueueUseCase: sl(),
      setCarStatusAsRetrievingUseCase: sl(), getGuestPriceUseCase: sl(), getValetParkingTypes: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ParkCarUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangeParkStatusUseCase(repository: sl()));
  sl.registerLazySingleton(() => CarDeliveredUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetValetHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSlotNumberUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCarsQueueUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetGuestPriceUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetValetParkingTypesUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => SetCarStatusAsRetrievingUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<ValetRepository>(
    () => ValetRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ValetRemoteDataSource>(
    () => ValetRemoteDataSourceImpl(),
  );
}
