import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/repository/wallet_repository_impl.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/get_cards_usecase.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> walletInjection() async {
  // Cubit
  sl.registerFactory(
        () => WalletCubit(getCardsUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCardsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WalletLocalDataSource>(
    () => WalletLocalDataSourceImpl(),
  );
}
