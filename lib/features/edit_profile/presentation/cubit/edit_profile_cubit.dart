import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/usecase/edit_profile_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  static EditProfileCubit get(BuildContext context) => BlocProvider.of(context);

  EditProfileCubit({required this.editProfileUseCase})
      : super(EditProfileInitial());
  final EditProfileUseCase editProfileUseCase;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

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
}
