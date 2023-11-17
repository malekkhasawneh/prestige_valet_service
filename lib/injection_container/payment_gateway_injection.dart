import 'package:prestige_valet_app/features/payment_gateway/data/datasource/payment_gateway_remote_datasource.dart';
import 'package:prestige_valet_app/features/payment_gateway/data/repository/payment_gateway_repository_impl.dart';
import 'package:prestige_valet_app/features/payment_gateway/domain/repository/payment_gateway_repository.dart';
import 'package:prestige_valet_app/features/payment_gateway/presentation/cubit/payment_gateway_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> paymentGatewayInjection() async {
  // Cubit
  sl.registerFactory(
    () => PaymentGatewayCubit(),
  );

  // Use cases
  //sl.registerLazySingleton(() => SignInUsingFacebookUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PaymentGatewayRepository>(
    () => PaymentGatewayRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PaymentGatewayRemoteDataSource>(
    () => PaymentGatewayRemoteDataSourceImpl(),
  );
}
