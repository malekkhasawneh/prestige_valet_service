import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  static ScanQrCubit get(BuildContext context) => BlocProvider.of(context);

  ScanQrCubit() : super(ScanQrInitial());

  Future<void> scanQrCode() async {
    await BarcodeScanner.scan();
  }
}
