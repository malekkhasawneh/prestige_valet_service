import 'package:equatable/equatable.dart';
import 'package:thermal_printer/thermal_printer.dart';

class BluetoothPrinter extends Equatable {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter(
      {this.deviceName,
      this.address,
      this.port,
      this.state,
      this.vendorId,
      this.productId,
      this.typePrinter = PrinterType.bluetooth,
      this.isBle = false});

  @override
  List<Object?> get props => [
        deviceName,
        address,
        port,
        state,
        vendorId,
        productId,
        typePrinter,
        isBle,
      ];
}
