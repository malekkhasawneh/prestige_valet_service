import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/usecase/encrypt_user_id_usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/usecase/sign_in_using_facebook_usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/usecase/sign_in_using_gmail_usecase.dart';

part 'social_auth_state.dart';

class SocialAuthCubit extends Cubit<SocialAuthState> {
  static SocialAuthCubit get(BuildContext context) => BlocProvider.of(context);

  SocialAuthCubit({
    required this.signInUsingFacebookUseCase,
    required this.signInUsingGmailUseCase,
    required this.encryptUserIdUseCase,
  }) : super(SocialAuthInitial());
  final SignInUsingFacebookUseCase signInUsingFacebookUseCase;
  final SignInUsingGmailUseCase signInUsingGmailUseCase;
  final EncryptUserIdUseCase encryptUserIdUseCase;

  Future<void> signInUsingGmail() async {
    emit(SocialAuthLoading());
    try {
      final response = await signInUsingGmailUseCase(NoParams());
      response.fold(
        (failure) => emit(
          SocialAuthError(
            failure: failure.toString(),
          ),
        ),
        (success) {
          emit(
            SocialAuthLoaded(
              userModel: success,
            ),
          );
        },
      );
    } catch (failure) {
      emit(SocialAuthError(failure: failure.toString()));
    }
  }

  Future<void> signInUsingFacebook() async {
    emit(SocialAuthLoading());
    try {
      final response = await signInUsingFacebookUseCase(NoParams());
      response.fold(
        (failure) => emit(
          SocialAuthError(
            failure: failure.toString(),
          ),
        ),
        (success) {
          log('====================================== token ${success.credential!.accessToken}');
          log('====================================== user name ${success.user!.displayName}');
          emit(
            SocialAuthLoaded(
              userModel: success,
            ),
          );
        },
      );
    } catch (failure) {
      emit(SocialAuthError(failure: failure.toString()));
    }
  }

  Future<void> encryptUserId({required String userId}) async {
    emit(SocialAuthEncryptUserIdLoading());
    try {
      final response = await encryptUserIdUseCase(
          EncryptUserIdUseCaseParams(userId: userId));
      response.fold(
        (failure) {
          log('===================================== encrypted user id $failure');
          emit(
          SocialAuthEncryptUserIdError(
            failure: failure.toString(),
          ),
        );
        },
        (encryptedData) {
          log('===================================== encrypted user id $encryptedData');
          emit(
            SocialAuthEncryptUserIdLoaded(),
          );
        },
      );
    } catch (failure) {
      log('===================================== encrypted user id catch $failure');

      emit(SocialAuthEncryptUserIdError(failure: failure.toString()));
    }
  }
}
