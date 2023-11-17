import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  static EditProfileCubit get(BuildContext context) => BlocProvider.of(context);

  EditProfileCubit() : super(EditProfileInitial());


  final TextEditingController firstName =
  TextEditingController();
  final TextEditingController lastName =
  TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email =
  TextEditingController();
}
