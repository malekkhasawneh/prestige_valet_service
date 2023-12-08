import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/pick_up/data/model/gates_model.dart';
import 'package:prestige_valet_app/features/pick_up/domain/usecase/get_gates_usecase.dart';

part 'pick_up_state.dart';

class PickUpCubit extends Cubit<PickUpState> {
  static PickUpCubit get(BuildContext context) => BlocProvider.of(context);

  PickUpCubit({
    required this.getGatesUseCase,
  }) : super(PickUpInitial());

  final GetGatesUseCase getGatesUseCase;

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      screenHeight * 0.3;

  int _selectedGateId = 0;

  int get selectedGateId => _selectedGateId;

  set setSelectedGateId(int value) {
    emit(SetValueLoading());
    _selectedGateId = value;
    emit(SetValueLoaded());
  }

  Future<void> getGates() async {
    emit(PickUpLoading());
    try {
      final response = await getGatesUseCase(NoParams());
      response.fold(
          (failure) => emit(PickUpError(
                failure: failure.failure,
              )), (gates) {
        _selectedGateId =
            gates.content.firstWhere((gate) => gate.isSelected).id;
        emit(PickUpLoaded(
          gatesModel: gates,
        ));
      });
    } catch (failure) {
      emit(PickUpError(failure: failure.toString()));
    }
  }
}
