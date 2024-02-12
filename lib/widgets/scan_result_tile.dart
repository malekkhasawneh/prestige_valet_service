import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  @override
  State<ScanResultTile> createState() => _ScanResultTileState();
}

class _ScanResultTileState extends State<ScanResultTile> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]';
  }

  String getNiceManufacturerData(List<List<int>> data) {
    return data.map((val) => '${getNiceHexArray(val)}').join(', ').toUpperCase();
  }

  String getNiceServiceData(Map<Guid, List<int>> data) {
    return data.entries.map((v) => '${v.key}: ${getNiceHexArray(v.value)}').join(', ').toUpperCase();
  }

  String getNiceServiceUuids(List<Guid> serviceUuids) {
    return serviceUuids.join(', ').toUpperCase();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.result.device.advName,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: (widget.result.advertisementData.connectable &&
              (ScanQrCubit.get(context).connectedDeviceName !=
                  widget.result.device.advName))
          ? () {
              ScanQrCubit.get(context).setConnect(
                  widget.result.device.remoteId.str,
                  widget.result.device.advName);
            }
          : null,
      child: ScanQrCubit.get(context).connectedDeviceName ==
              widget.result.device.advName
          ? const Text('Connected')
          : const Text('Connect'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanQrCubit, ScanQrState>(builder: (context, state) {
      return widget.result.device.advName.isEmpty
          ? const SizedBox()
          : ExpansionTile(
              title: _buildTitle(context),
              trailing: _buildConnectButton(context),
            );
    });
  }
}
