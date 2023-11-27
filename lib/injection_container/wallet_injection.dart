import 'package:prestige_valet_app/features/sign_up/data/datasource/sign_up_local_datasource.dart';
import 'package:prestige_valet_app/features/sign_up/data/datasource/sign_up_remote_datasource.dart';
import 'package:prestige_valet_app/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/set_user_model_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_remote_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/repository/wallet_repository_impl.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/get_cards_usecase.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> walletInjection() async {
  // Cubit
  sl.registerFactory(
        () => WalletCubit(getCardsUseCase: sl()
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCardsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
        () => WalletRepositoryImpl(
        networkInfo: sl(), remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
        () => WalletRemoteDataSourceImpl(),
  );
}
