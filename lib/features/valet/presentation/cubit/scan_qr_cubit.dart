import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/car_delivered_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/change_park_status_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_valet_history_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/park_car_usecase.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  static ScanQrCubit get(BuildContext context) => BlocProvider.of(context);

  ScanQrCubit({
    required this.parkCarUseCase,
    required this.changeParkStatusUseCase,
    required this.carDeliveredUseCase,
    required this.getValetHistoryUseCase,
  }) : super(ScanQrInitial());

  final ParkCarUseCase parkCarUseCase;
  final ChangeParkStatusUseCase changeParkStatusUseCase;
  final CarDeliveredUseCase carDeliveredUseCase;
  final GetValetHistoryUseCase getValetHistoryUseCase;

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

  Future<void> changeParkedCarStatus({required int parkingId}) async {
    emit(ScanQrLoading());
    try {
      final response = await changeParkStatusUseCase(
          ChangeParkStatusUseCaseParams(parkingId: parkingId));
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

  Future<void> carDelivered({required int parkingId}) async {
    emit(ScanQrLoading());
    try {
      final response = await carDeliveredUseCase(
          CarDeliveredUseCaseParams(parkingId: parkingId));
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

  Future<void> getValetHistory({required int valetId}) async {
    emit(ScanQrLoading());
    try {
      final response = await getValetHistoryUseCase(
          GetValetHistoryUseCaseParams(valetId: valetId));
      response.fold(
        (failure) {
          log('========================================= mmmm ${failure.failure}');

          emit(ScanQrError(failure: failure.failure));
        },
        (success) {
          log('========================================= mmmm ${success.content.length}');
          emit(
            GetValetHistoryLoaded(
              valetHistoryModel: success,
            ),
          );
        },
      );
    } catch (failure) {
      emit(ScanQrError(failure: failure.toString()));
    }
  }

  String status({required String status}) {
    switch (status) {
      case 'DELIVERED_TO_GATEKEEPER':
        return 'Delivered to gatekeeper';
      case 'PARKED':
        return 'Parked';
      case 'DELIVERED_TO_USER':
        return 'Delivered to user';
      case 'RETRIEVING':
        return 'Retrieve the car';
      default:
        return status;
    }
  }

  Color retrieveButtonColor({required String status}) {
    return status == 'Retrieve the car'
        ? ColorManager.primaryColor
        : ColorManager.blackColor;
  }
}
