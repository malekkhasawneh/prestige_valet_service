import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
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
    return Stack(
      children: [
        QrImageView(
          data:
              '${HomeCubit.get(context).userModel.user.userId},${HomeCubit.get(context).userModel.user.id}',
          version: QrVersions.auto,
          size: HomeCubit.get(context).bodyBoxHeight(context, screenHeight) *
              0.47,
          gapless: false,
        ),
        (HomeCubit.get(context).isUserCarParked ||
                HomeCubit.get(context).isUserCarInRetrieve)
            ? Container(
                color: ColorManager.primaryColor.withOpacity(.8),
                height: HomeCubit.get(context)
                        .bodyBoxHeight(context, screenHeight) *
                    0.47,
                width: HomeCubit.get(context)
                        .bodyBoxHeight(context, screenHeight) *
                    0.47,
                child: const Center(
                    child: Text(
                  'Your car is parked safely',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorManager.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
