import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/item_widget.dart';

class ProfileItemsWidget extends StatelessWidget {
  const ProfileItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ProfileCubit.get(context).isTablet(screenWidth)
                ? screenWidth * 0.03
                : screenWidth * 0.055,
            vertical: 20,
          ),
          child: const Text(
            Strings.editProfile,
            style: TextStyle(
              fontFamily: Fonts.montserrat,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        ItemWidget(
          icon: Icons.person,
          title: 'Account Settings',
          onPressed: () {},
        ),
        SizedBox(
          height: ProfileCubit.get(context).isTablet(screenWidth) ? 25 : 0,
        ),
        ItemWidget(
          icon: Icons.money,
          title: 'Payment Methods',
          onPressed: () {},
        ),
        SizedBox(
          height: ProfileCubit.get(context).isTablet(screenWidth) ? 25 : 0,
        ),
        ItemWidget(
          icon: Icons.history,
          title: 'History',
          onPressed: () {},
        ),
        SizedBox(
          height: ProfileCubit.get(context).isTablet(screenWidth) ? 25 : 0,
        ),
      ],
    );
  }
}
