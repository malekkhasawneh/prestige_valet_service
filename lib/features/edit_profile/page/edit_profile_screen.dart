import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/edit_profile/widgets/save_changes_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        elevation: 0,
        title: const Text(
          Strings.profile,
          style: TextStyle(
            fontFamily: Fonts.sourceSansPro,
            fontSize: 26,
            color: ColorManager.blackColor,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: ColorManager.blackColor,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'src',
                    width: 85,
                    height: 85,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        Images.defaultUserImage,
                        height: 85,
                        width: 85,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                     await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                  },
                  child: const Text(
                    Strings.changeProfilePic,
                    style: TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFieldWidget(
                  controller: EditProfileCubit.get(context).firstName,
                  title: Strings.firstName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controller: EditProfileCubit.get(context).lastName,
                  title: Strings.lastName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controller: EditProfileCubit.get(context).phoneNumber,
                  title: Strings.phoneNumber,
                  textInputType: TextInputType.phone,
                  addPrefixIcon: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controller: EditProfileCubit.get(context).email,
                  title: Strings.email,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 50,
                ),
                const SaveChangesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
