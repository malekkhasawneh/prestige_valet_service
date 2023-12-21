import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GuestQrWidget extends StatelessWidget {
  const GuestQrWidget({
    super.key,
    required this.screenHeight,
    required this.parkedCarsModel,
  });

  final double screenHeight;
  final ParkedCarsModel parkedCarsModel;

  @override
  Widget build(BuildContext context) {
    log('=============================== qr code data ${parkedCarsModel.guestName}${DateTime.now().microsecondsSinceEpoch},${parkedCarsModel.id}');
    return Scaffold(
      body: Center(
        child: QrImageView(
          data:
              '${parkedCarsModel.guestName}${DateTime.now().microsecondsSinceEpoch},${parkedCarsModel.id}',
          version: QrVersions.auto,
          size:
              HomeCubit.get(context).bodyBoxHeight(context, screenHeight) * 0.6,
          gapless: false,
        ),
      ),
    );
  }
}
