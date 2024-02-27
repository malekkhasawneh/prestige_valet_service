import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';

class ParkingCardWidget extends StatelessWidget {
  const ParkingCardWidget({
    super.key,
    required this.status,
    required this.parkingId,
    required this.phone,
    required this.name,
    required this.imageUrl,
    required this.isGuest,
    required this.gate,
  });

  final String phone;
  final String name;
  final String imageUrl;
  final String status;
  final int parkingId;
  final bool isGuest;
  final String gate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 17),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 22),
            padding: const EdgeInsets.only(left: 10, bottom: 30),
            decoration: BoxDecoration(
              color: ColorManager.greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      imageUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                      headers: DioHelper.headers(
                          HomeCubit.get(context).userModel.token),
                      errorBuilder: (_, __, ___) {
                        return Image.asset(
                          Images.defaultUserImage,
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      fontSize: 13,
                    ),
                  ),
                  subtitle: Text(
                  phone.split(',').last.isEmpty
                        ? ''
                        : '0${phone.split(',').last}',
                    style: const TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gate.isEmpty ? "" : Strings.gate,
                        style: const TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        gate,
                        style: const TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            child: SizedBox(
              height: 35,
              child: ElevatedButton(
                onPressed: ScanQrCubit.get(context)
                            .retrieveButtonColor(status: status) ==
                        ColorManager.blackColor
                    ? () {
                        log('======================================== View only');
                      }
                    : () {
                        if (isGuest) {
                          ScanQrCubit.get(context).retrieveGuestCar();
                        } else {
                          ScanQrCubit.get(context)
                              .carDelivered(parkingId: parkingId);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ScanQrCubit.get(context)
                      .retrieveButtonColor(status: status),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25), // Adjust the radius as needed
                  ),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.whiteColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
