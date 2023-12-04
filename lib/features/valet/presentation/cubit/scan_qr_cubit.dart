import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/park_car_usecase.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  static ScanQrCubit get(BuildContext context) => BlocProvider.of(context);

  ScanQrCubit({required this.parkCarUseCase}) : super(ScanQrInitial());

  final ParkCarUseCase parkCarUseCase;

  Future<void> parkCar({required int valetId}) async {
    emit(ScanQrLoading());
    try {
      final response =
          await parkCarUseCase(ParkCarUseCaseParams(valetId: valetId));
      response.fold(
        (failure) => emit(ScanQrError(failure: failure.failure)),
        (success) => emit(
          ScanQrLoaded(
            parkedCarsModel: success,
          ),
        ),
      );
    } catch (failure) {
      emit(ScanQrError(failure: failure.toString()));
    }
  }
}
