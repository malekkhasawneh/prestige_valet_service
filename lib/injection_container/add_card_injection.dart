import 'package:prestige_valet_app/features/add_credit_card/data/datasource/add_card_remote_datasource.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/repository/add_card_repository_impl.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/repository/add_card_repository.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/usecase/add_new_card_usecase.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> addCardInjection() async {
  // Cubit
  sl.registerFactory(
    () => AddCreditCardCubit(addNewCardUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AddNewCardUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AddCardRepository>(
    () => AddCardRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources

  sl.registerLazySingleton<AddCardRemoteDataSource>(
    () => AddCardRemoteDataSourceImpl(),
  );
}
