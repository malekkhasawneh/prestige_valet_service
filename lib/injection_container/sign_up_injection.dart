import 'package:prestige_valet_app/features/sign_up/data/datasource/sign_up_remote_datasource.dart';
import 'package:prestige_valet_app/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> signUpInjection() async {
  // Cubit
  sl.registerFactory(
    () => SignUpCubit(signUpUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(
      networkInfo: sl(),
      signUpRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(),
  );
}