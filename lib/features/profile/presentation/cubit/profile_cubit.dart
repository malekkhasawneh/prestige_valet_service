import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/profile/domain/usecase/clear_cache_usecase.dart';
import 'package:prestige_valet_app/features/profile/domain/usecase/logout_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  ProfileCubit({
    required this.logoutUseCase,
    required this.clearCacheUseCase,
  }) : super(ProfileInitial());

  final LogoutUseCase logoutUseCase;
  final ClearCacheUseCase clearCacheUseCase;

  bool isTablet(double screenWidth) => screenWidth > 600;

  Future<void> logout({required int userId}) async {
    emit(ProfileLoading());
    try {
      final response = await logoutUseCase(LogoutUseCaseParams(userId: userId));
      response.fold(
        (failure) => emit(ProfileError(failure: failure.failure)),
        (success) async {
          if (success) {
            await clearCache();
          }
          emit(
            ProfileLoaded(
              logout: success,
            ),
          );
        },
      );
    } catch (error) {
      emit(ProfileError(failure: error.toString()));
    }
  }

  Future<void> clearCache() async {
    emit(ProfileLoading());
    try {
      final response = await clearCacheUseCase(NoParams());
      response.fold((failure) => emit(ProfileError(failure: failure.failure)),
          (success) {
        emit(ClearCacheState());
      });
    } catch (failure) {
      emit(ProfileError(failure: failure.toString()));
    }
  }
}
