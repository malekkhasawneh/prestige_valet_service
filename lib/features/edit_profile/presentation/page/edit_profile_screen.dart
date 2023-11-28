import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/widgets/save_changes_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    EditProfileCubit.get(context).firstName.text =
        HomeCubit.get(context).userModel.user.firstName;
    EditProfileCubit.get(context).lastName.text =
        HomeCubit.get(context).userModel.user.lastName;
    EditProfileCubit.get(context).email.text =
        HomeCubit.get(context).userModel.user.email;
    EditProfileCubit.get(context).phoneNumber.text =
        HomeCubit.get(context).userModel.user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
      if (state is EditProfileLoaded) {
        HomeCubit.get(context).userModel.user = state.userModel;
        AwesomeDialog(
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Text(
              'Edited\n ',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          btnOkOnPress: () {},
        ).show();
      }
    }, builder: (context, state) {
      log('============================================== mmmmmmmmm ${HomeCubit.get(context).userModel.user.profileImg}');
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
                      'http://82.208.22.118/prestige/api/v1/auth/user/image/User-Profile-NO-52.jpg',
                      width: 85,
                      height: 85,
                      headers: const {
                        'Authorization':
                            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtYWxla21hbW9vbjM0MUBnbWFpbC5jb20iLCJpYXQiOjE3MDExMDk4MzcsImV4cCI6MTcwNjI5MzgzN30.Vc4-ZA6MtlD03a5iEHEOKQb-3dlcin8thHE5YfqPiis',
                        'Content-Type': 'application/json',
                      },
                      errorBuilder: (_, __, ___) {
                        return Image.asset(
                          Images.defaultUserImage,
                          height: 85,
                          width: 85,
                        );
                      },
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      // ignore: use_build_context_synchronously
                      await DioHelper.uploadImage(
                          File(image!.path),
                          context,
                          // ignore: use_build_context_synchronously
                          HomeCubit.get(context).userModel.user.id);
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
                    readOnly:
                        HomeCubit.get(context).userModel.user.socialProfile,
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
    });
  }
}