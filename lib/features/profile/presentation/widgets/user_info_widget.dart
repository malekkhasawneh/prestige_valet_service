import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            HomeCubit.get(context).userModel.user.profileImg,
            headers: {
              'Authorization':
              'Bearer ${HomeCubit.get(context).userModel.token}',
              'Content-Type': 'application/json',
            },
            width: ProfileCubit.get(context).isTablet(screenWidth)
                ? screenWidth * 0.13
                : screenWidth * 0.17,
            height: ProfileCubit.get(context).isTablet(screenWidth)
                ? screenWidth * 0.2
                : screenHeight * 0.15,
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) {
              return Image.asset(
                Images.defaultUserImage,
                width: ProfileCubit.get(context).isTablet(screenWidth)
                    ? screenWidth * 0.13
                    : screenWidth * 0.17,
                height: ProfileCubit.get(context).isTablet(screenWidth)
                    ? screenWidth * 0.2
                    : screenHeight * 0.15,
                fit: BoxFit.fill,
              );
            },
          ),
        ),
        title: const Text(
          'John Doe',
          style: TextStyle(
            fontFamily: Fonts.sourceSansPro,
            fontSize: 20,
            color: ColorManager.blackColor,
          ),
        ),
        subtitle: const Text(
          'Manage your account',
          style: TextStyle(
            fontFamily: Fonts.montserrat,
            color: Colors.grey,
          ),
        ),
        trailing: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routes.editProfileScreen);
          },
          child: const Icon(
            Icons.edit,
            size: 18,
          ),
        ),
      ),
    );
  }
}
