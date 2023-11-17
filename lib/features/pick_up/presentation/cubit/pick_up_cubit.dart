import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pick_up_state.dart';

class PickUpCubit extends Cubit<PickUpState> {
  static PickUpCubit get(BuildContext context) => BlocProvider.of(context);

  PickUpCubit() : super(PickUpInitial());

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      screenHeight * 0.3;

  int _selectedGate = 1;

  int get getSelectedGate => _selectedGate;

  set setSelectedGate(int value) {
    emit(PickUpLoading());
    _selectedGate = value;
    emit(PickUpLoaded());
  }

  List<Map<String, dynamic>> gates = [
    {'id': 1, 'gate': 'Gate1'},
    {'id': 2, 'gate': 'Gate2'},
    {'id': 3, 'gate': 'Gate3'},
    {'id': 4, 'gate': 'Gate4'},
  ];
}
