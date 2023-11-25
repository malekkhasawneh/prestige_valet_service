import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Routes.carParkedHomeScreen);
      },
      child: QrImageView(
        data: HomeCubit.get(context).userModel.user.userId,
        version: QrVersions.auto,
        size:
            HomeCubit.get(context).bodyBoxHeight(context, screenHeight) * 0.47,
        gapless: false,
      ),
    );
  }
}
