import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_remote_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/repository/wallet_repository_impl.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/execute_payment_usecase.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/get_cards_usecase.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> walletInjection() async {
  // Cubit
  sl.registerFactory(
    () => WalletCubit(getCardsUseCase: sl(), executePaymentUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCardsUseCase(repository: sl()));
  sl.registerLazySingleton(() => ExecutePaymentUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(),
  );
}
