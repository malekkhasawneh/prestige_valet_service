import 'dart:async';
import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/bluetooth_printer_entity.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/car_delivered_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/change_park_status_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_valet_history_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/park_car_usecase.dart';
import 'package:thermal_printer/esc_pos_utils_platform/esc_pos_utils_platform.dart';
import 'package:thermal_printer/thermal_printer.dart';

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
  var printerManager = PrinterManager.instance;
  BluetoothPrinter? selectedPrinter;

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

  //Printer methods

  Future printQrForGuest(String qrData) async {
    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    final generator = Generator(PaperSize.mm58, profile);
    _printEscPos(await getGraphicsTicket(qrData), generator);
  }

  Future<List<int>> getGraphicsTicket(String qrString) async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes +=
        generator.qrcode(qrString, size: const QRSize(9), cor: QRCorrection.H);
    bytes += generator.text('\n' '');
    bytes += generator.cut();
    return bytes;
  }

  void _printEscPos(List<int> bytes, Generator generator) async {
    var bluetoothPrinter = selectedPrinter!;
    printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
  }

  Future<void> connectDevice({bool isAutoConnect = false}) async {
    emit(SetValueLoading());
    connected = false;
    await printerManager.connect(
      type: PrinterType.bluetooth,
      model: BluetoothPrinterInput(
        name: selectedPrinter!.deviceName,
        address: selectedPrinter!.address!,
        autoConnect: true,
      ),
    );
    connectedDeviceName = selectedPrinter!.deviceName ?? '';
    emit(SetValueLoaded());
  }

  Future<void> disconnect() async {
    emit(SetValueLoading());
    PrinterManager.instance.disconnect(type: PrinterType.bluetooth);
    connected = false;
    connectedDeviceName = '';
    emit(SetValueLoaded());
  }
}
