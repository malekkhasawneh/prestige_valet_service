import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
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

  bool connected = false;
  List availableBluetoothDevices = [];
  String connectedDeviceName = '';

  Future<void> parkCar({required int valetId, bool isGuest = false}) async {
    emit(ScanQrLoading());
    try {
      final response = await parkCarUseCase(ParkCarUseCaseParams(
        valetId: valetId,
        isGuest: isGuest,
      ));
      response.fold(
        (failure) {
          log('=================================== here ${failure.failure}');
          emit(ScanQrError(failure: failure.failure));
        },
        (success) {
          log('=================================== here ${success.id}');

          emit(
            ScanQrLoaded(
              parkedCarsModel: success,
            ),
          );
        },
      );
    } catch (failure) {
      log('=================================== heresssss ${failure.toString()}');

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

  Future<void> retrieveGuestCar() async {
    var result = await BarcodeScanner.scan();
    if (result.rawContent.isNotEmpty && result.rawContent.contains('Guest')) {
      emit(ScanQrLoading());
      try {
        final response = await carDeliveredUseCase(CarDeliveredUseCaseParams(
            parkingId: int.parse(result.rawContent.split(',').last)));
        response.fold(
          (failure) => emit(ScanQrError(failure: failure.failure)),
          (success) => emit(
            RetrieveGuestCarLoaded(),
          ),
        );
      } catch (failure) {
        emit(ScanQrError(failure: failure.toString()));
      }
    } else {
      emit(const RetrieveGuestCarLoadedError(failure: 'Invalid QR code'));
    }
  }

  Future<void> getValetHistory(
      {required int valetId, bool canLoading = true}) async {
    if (canLoading) emit(ScanQrLoading());
    try {
      final response = await getValetHistoryUseCase(
          GetValetHistoryUseCaseParams(valetId: valetId));
      response.fold(
        (failure) {
          log('====================================== error ${failure.failure}');
          emit(ScanQrError(failure: failure.failure));
        },
        (success) {
          log('====================================== error ${success.content.first.id}');

          emit(
            GetValetHistoryLoaded(
              valetHistoryModel: success,
            ),
          );
        },
      );
    } catch (failure) {
      log('====================================== error ${failure.toString()}');

      emit(ScanQrError(failure: failure.toString()));
    }
  }

  String status({required String status, required bool isGuest}) {
    switch (status) {
      case 'DELIVERED_TO_GATEKEEPER':
        return 'Delivered to gatekeeper';
      case 'PARKED':
        if (isGuest) {
          return 'Retrieve the car';
        } else {
          return 'Parked';
        }
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

  Future<void> isPrinterConnected() async {
    emit(SetValueLoading());
    connected =
        bool.parse(await BluetoothThermalPrinter.connectionStatus ?? 'false');
    connectedDeviceName =  connectedDeviceName.isEmpty
        ? await CacheHelper.getValue(key: 'connectedDeviceName')
        : connectedDeviceName;
    emit(SetValueLoaded());
  }

  Future<void> getBluetooth() async {
    emit(SetValueLoading());
    final List? bluetooth = await BluetoothThermalPrinter.getBluetooths;
    log("Print $bluetooth");
    availableBluetoothDevices = bluetooth!;
    emit(SetValueLoaded());
  }

  Future<void> setConnect(String mac, String deviceName) async {
    emit(SetValueLoading());
    final String? result = await BluetoothThermalPrinter.connect(mac);
    log("state connected $result");
    if (result == "true") {
      await CacheHelper.setValue(key: 'connectedDeviceName', value: deviceName);
      connectedDeviceName = deviceName;
      connected = true;
    }
    emit(SetValueLoaded());
  }

  Future<void> printGraphics(String qrString) async {
    emit(SetValueLoading());
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getGraphicsTicket(qrString);
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      log("Print $result");
    } else {
      emit(const PrinterNotConnectedError(failure: 'No connected printer'));
    }
    emit(SetValueLoaded());
  }

  Future<List<int>> getGraphicsTicket(String qrString) async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes +=
        generator.qrcode(qrString, size: const QRSize(9), cor: QRCorrection.H);
    bytes += generator.text('\n' '');
    bytes += generator.cut();
    return bytes;
  }
}
