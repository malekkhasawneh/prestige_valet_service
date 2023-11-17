import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  ProfileCubit() : super(ProfileInitial());

  bool isTablet(double screenWidth) => screenWidth > 600;
}
