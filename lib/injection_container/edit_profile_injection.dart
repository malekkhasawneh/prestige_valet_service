import 'package:prestige_valet_app/features/edit_profile/data/datasource/profile_remote_datasource.dart';
import 'package:prestige_valet_app/features/edit_profile/data/repository/profile_repository_impl.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/repository/profile_repository.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/usecase/edit_profile_usecase.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart';

Future<void> editProfileInjection() async {
  // Cubit
  sl.registerFactory(
    () => EditProfileCubit(editProfileUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => EditProfileUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
}
