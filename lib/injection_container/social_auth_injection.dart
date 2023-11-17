import 'package:prestige_valet_app/features/social_auth/data/datasource/social_auth_local_datasource.dart';
import 'package:prestige_valet_app/features/social_auth/data/datasource/social_auth_remote_datasource.dart';
import 'package:prestige_valet_app/features/social_auth/data/repository/social_auth_repoaitory_impl.dart';
import 'package:prestige_valet_app/features/social_auth/domain/repository/social_auth_repository.dart';
import 'package:prestige_valet_app/features/social_auth/domain/usecase/encrypt_user_id_usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/usecase/sign_in_using_facebook_usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/usecase/sign_in_using_gmail_usecase.dart';
import 'package:prestige_valet_app/features/social_auth/presentation/cubit/social_auth_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> socialAuthInjection() async {
  // Cubit
  sl.registerFactory(
    () => SocialAuthCubit(
      signInUsingFacebookUseCase: sl(),
      signInUsingGmailUseCase: sl(),
      encryptUserIdUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => SignInUsingFacebookUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SignInUsingGmailUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => EncryptUserIdUseCase(
      repository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<SocialAuthRepository>(
    () => SocialAuthRepositoryImpl(
        networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SocialAuthRemoteDataSource>(
    () => SocialAuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<SocialAuthLocalDataSource>(
    () => SocialAuthLocalDataSourceImpl(),
  );
}
