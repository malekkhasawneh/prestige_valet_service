import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/usecase/edit_profile_usecase.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/usecase/upload_user_image_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  static EditProfileCubit get(BuildContext context) => BlocProvider.of(context);

  EditProfileCubit({
    required this.editProfileUseCase,
    required this.uploadUserImageUseCase,
  }) : super(EditProfileInitial());
  final EditProfileUseCase editProfileUseCase;
  final UploadUserImageUseCase uploadUserImageUseCase;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  bool _mustCheck = false;

  bool get mustCheck => _mustCheck;

  set setMustCheck(bool value) {
    emit(SetAndGetValueLoading());
    _mustCheck = value;
    emit(SetAndGetValueLoaded());
  }

  File file = File('');

  Future<void> editProfile({required int userId}) async {
    emit(EditProfileLoading());
    try {
      final response = await editProfileUseCase(EditProfileUseCaseParams(
          userId: userId,
          firstName: firstName.text,
          lastName: lastName.text,
          phone: phoneNumber.text,
          email: email.text));
      response.fold(
          (failure) => emit(EditProfileError(failure: failure.failure)),
          (userModel) => emit(EditProfileLoaded(userModel: userModel)));
    } catch (failure) {
      emit(EditProfileError(failure: failure.toString()));
    }
  }

  Future<void> uploadUserImage(
      {required BuildContext context,
      required File image,
      required int userId}) async {
    emit(UploadUserImageLoading());
    try {
      final response = await uploadUserImageUseCase(
          UploadUserImageUseCaseParams(
              userId: userId, image: image, context: context));
      response
          .fold((failure) => emit(EditProfileError(failure: failure.failure)),
              (success) {
        if (!success) {
          file = File('');
        }
        emit(UploadUserImage());
      });
    } catch (failure) {
      emit(EditProfileError(failure: failure.toString()));
    }
  }

  bool checkIfThereAreEmptyValue() {
    return firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        email.text.isEmpty;
  }
}
