import 'package:prestige_valet_app/features/home/data/datasource/home_local_datasource.dart';
import 'package:prestige_valet_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:prestige_valet_app/features/home/data/repository/home_repository_impl.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/cancel_car_retrieving_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/check_internet_connction_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_data_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_history_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/retrieve_car_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/wash_car_usecase.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

import '../features/home/domain/usecase/delete_firebase_account_usecase.dart';

Future<void> homeInjection() async {
  // Cubit
  sl.registerFactory(
    () => HomeCubit(
      getUserDataUseCase: sl(),
      retrieveCarUseCase: sl(),
      washCarUseCase: sl(),
      getUserHistoryUseCase: sl(),
      cancelCarRetrievingUseCase: sl(),
      deleteFirebaseAccountUseCase: sl(),
      checkInternetConnectionUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => RetrieveCarUseCase(repository: sl()));
  sl.registerLazySingleton(() => WashCarUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => CancelCarRetrievingUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => DeleteFirebaseAccountUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => CheckInternetConnectionUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(networkInfo: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
}
