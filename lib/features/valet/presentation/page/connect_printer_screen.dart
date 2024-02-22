// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/features/valet/domain/bluetooth_printer_entity.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:thermal_printer/thermal_printer.dart';

class ConnectPrinterScreen extends StatefulWidget {
  const ConnectPrinterScreen({super.key});

  @override
  State<ConnectPrinterScreen> createState() => _ConnectPrinterScreenState();
}

class _ConnectPrinterScreenState extends State<ConnectPrinterScreen> {
  var defaultPrinterType = PrinterType.bluetooth;
  final _isBle = false;
  final _reconnect = false;
  var devices = <BluetoothPrinter>[];
  StreamSubscription<PrinterDevice>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  StreamSubscription<USBStatus>? _subscriptionUsbStatus;
  StreamSubscription<TCPStatus>? _subscriptionTCPStatus;
  BTStatus _currentStatus = BTStatus.none;

  // ignore: unused_field
  TCPStatus _currentTCPStatus = TCPStatus.none;

  // _currentUsbStatus is only supports on Android
  // ignore: unused_field
  USBStatus _currentUsbStatus = USBStatus.none;
  List<int>? pendingTask;
  String _ipAddress = '';
  String _port = '9100';
  final _ipController = TextEditingController();
  final _portController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _portController.text = _port;
    _scan();
    _subscriptionBtStatus =
        PrinterManager.instance.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      _currentStatus = status;
      if (status == BTStatus.connected) {
        setState(() {
          ScanQrCubit.get(context).connected = true;
        });
      }
      if (status == BTStatus.none) {
        setState(() {
          ScanQrCubit.get(context).connected = false;
        });
      }
      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.bluetooth, bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance
              .send(type: PrinterType.bluetooth, bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
    _subscriptionUsbStatus = PrinterManager.instance.stateUSB.listen((status) {
      log(' ----------------- status usb $status ------------------ ');
      _currentUsbStatus = status;
      if (Platform.isAndroid) {
        if (status == USBStatus.connected && pendingTask != null) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.usb, bytes: pendingTask!);
            pendingTask = null;
          });
        }
      }
    });
    _subscriptionTCPStatus = PrinterManager.instance.stateTCP.listen((status) {
      log(' ----------------- status tcp $status ------------------ ');
      _currentTCPStatus = status;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscriptionBtStatus?.cancel();
    _subscriptionUsbStatus?.cancel();
    _subscriptionTCPStatus?.cancel();
    _portController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  void _scan() {
    devices.clear();
    _subscription = ScanQrCubit.get(context)
        .printerManager
        .discovery(type: defaultPrinterType, isBle: _isBle)
        .listen((device) {
      devices.add(BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: _isBle,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: defaultPrinterType,
      ));
      setState(() {});
    });
  }

  void setPort(String value) {
    if (value.isEmpty) value = '9100';
    _port = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void setIpAddress(String value) {
    _ipAddress = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  Future<void> selectDevice(BluetoothPrinter device) async {
    if (ScanQrCubit.get(context).selectedPrinter != null) {
      if ((device.address !=
              ScanQrCubit.get(context).selectedPrinter!.address) ||
          (device.typePrinter == PrinterType.usb &&
              ScanQrCubit.get(context).selectedPrinter!.vendorId !=
                  device.vendorId)) {
        await ScanQrCubit.get(context).disconnect();
      }
    }

    ScanQrCubit.get(context).selectedPrinter = device;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available devices',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Column(
                    children: devices
                        .map(
                          (device) => ListTile(
                            title: Text('${device.deviceName}'),
                            trailing: SizedBox(
                              width: 155,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: ColorManager
                                          .primaryColor), // Set the border color here
                                ),
                                onPressed: ScanQrCubit.get(context).connected &&
                                        ScanQrCubit.get(context)
                                                .connectedDeviceName ==
                                            device.deviceName
                                    ? () {
                                  ScanQrCubit.get(context).disconnect();
                                        setState(() {
                                          ScanQrCubit.get(context).connected =
                                              false;
                                        });
                                      }
                                    : () async {
                                        if (ScanQrCubit.get(context)
                                            .connected) {
                                          ScanQrCubit.get(context).disconnect();
                                          setState(() {
                                            ScanQrCubit.get(context).connected =
                                                false;
                                            ScanQrCubit.get(context)
                                                .connectedDeviceName = '';
                                          });
                                        }
                                        await selectDevice(device).then(
                                          (_) {
                                            return ScanQrCubit.get(context)
                                                .connectDevice();
                                          },
                                        );
                                      },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  child: Text(
                                    ScanQrCubit.get(context).connected &&
                                            ScanQrCubit.get(context)
                                                    .connectedDeviceName ==
                                                device.deviceName
                                        ? "Disconnect"
                                        : "Connect",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: ColorManager.blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
