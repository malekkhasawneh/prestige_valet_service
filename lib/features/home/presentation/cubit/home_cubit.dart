import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  HomeCubit() : super(HomeInitial());

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      screenHeight * 0.3;
}
