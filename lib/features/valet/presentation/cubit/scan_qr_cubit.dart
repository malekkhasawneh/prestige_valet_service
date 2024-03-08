import 'dart:async';
import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/entity/bluetooth_printer_entity.dart';
import 'package:prestige_valet_app/features/valet/domain/entity/tab_entity.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/car_delivered_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/change_park_status_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/get_valet_history_usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/usecase/park_car_usecase.dart';
import 'package:prestige_valet_app/image_utils.dart';
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

  int _selectedTabId = 1;

  int get getSelectedTabId => _selectedTabId;

  set setSelectedTabId(int id) {
    emit(SetValueLoading());
    _selectedTabId = id;
    emit(SetValueLoaded());
  }

  List<TabEntity> tabs = [
    TabEntity(id: 1, text: Strings.inParking),
    TabEntity(id: 2, text: Strings.retrieved),
  ];

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

  late ParkHistoryModel parkHistoryModel;

  Future<void> getValetHistory(
      {required int valetId, bool canLoading = true}) async {
    if (canLoading) emit(ScanQrLoading());
    try {
      final response = await getValetHistoryUseCase(
          GetValetHistoryUseCaseParams(valetId: valetId));
      response.fold(
        (failure) {
          emit(ScanQrError(failure: failure.failure));
        },
        (success) {
          parkHistoryModel = success;
          if (_selectedTabId == 1) {
            for (var _ in parkHistoryModel.content) {
              parkHistoryModel.content.removeWhere(
                  (element) => element.parkingStatus == 'DELIVERED_TO_USER');
            }
          } else {
            for (var _ in parkHistoryModel.content) {
              parkHistoryModel.content.removeWhere(
                  (element) => element.parkingStatus != 'DELIVERED_TO_USER');
            }
          }
          emit(
            const GetValetHistoryLoaded(),
          );
        },
      );
    } catch (failure) {
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
    final ByteData data =
        await rootBundle.load('images/printer_header_logo.png');
    if (data.lengthInBytes > 0) {
      final Uint8List imageBytes = data.buffer.asUint8List();
      final decodedImage = img.decodeImage(imageBytes)!;
      img.Image thumbnail = img.copyResize(decodedImage, height: 200);
      img.Image originalImg =
          img.copyResize(decodedImage, width: 200, height: 200);
      var padding = (originalImg.width - thumbnail.width) / 1;
      drawImage(originalImg, thumbnail, dstX: padding.toInt());
      var grayscaleImage = img.grayscale(originalImg);
      bytes += generator.feed(1);
      bytes += generator.imageRaster(grayscaleImage, align: PosAlign.right);
      bytes += generator.feed(1);
    }
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
