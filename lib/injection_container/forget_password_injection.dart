import 'package:prestige_valet_app/features/forget_password/data/datasource/change_password_remote_datasource.dart';
import 'package:prestige_valet_app/features/forget_password/data/repository/change_password_repository_impl.dart';
import 'package:prestige_valet_app/features/forget_password/domain/repository/change_password_repository.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/chanege_password_usecase.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/send_reset_password_usecase.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/verify_otp_usecase.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> forgetPasswordInjection() async {
  // Cubit
  sl.registerFactory(
    () => ForgetPasswordCubit(
      changePasswordUseCase: sl(),
      sendResetPasswordOtpUseCase: sl(),
      verifyOtpUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ChangePasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => SendResetPasswordOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<ChangePasswordRepository>(
    () =>
        ChangePasswordRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
    () => ChangePasswordRemoteDataSourceImpl(),
  );
}
