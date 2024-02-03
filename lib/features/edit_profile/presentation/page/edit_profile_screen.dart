// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/widgets/save_changes_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/resources/route_manager.dart';

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
        EditProfileCubit.get(context).filterPhoneNumber(HomeCubit.get(context).userModel.user.phone);
    EditProfileCubit.get(context).setMustCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
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
        }else if(state is EditProfileError){
          if(state.failure == Constants.internetFailure){
            Navigator.pushNamed(context, Routes.noInternetScreen);
          }else if(state.failure == Constants.serverFailure){
            Navigator.pushReplacementNamed(context, Routes.loginScreen);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.whiteColor,
            elevation: 0,
            title: const Text(
              Strings.profile,
              style: TextStyle(
                fontFamily: Fonts.sourceSansPro,
                fontSize: 26,
                color: ColorManager.blackColor,
              ),
            ),
            leading: GestureDetector(onTap: (){
              Navigator.pop(context);
            },
              child: const Icon(
                Icons.arrow_back,
                color: ColorManager.blackColor,
                size: 30,
              ),
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
                      child: (state is UploadUserImageLoading)
                          ? Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.grey,
                              period: const Duration(seconds: 5),
                              child: Image.asset(
                                Images.defaultUserImage,
                                height: 85,
                                width: 85,
                                fit: BoxFit.fill,
                              ),
                            )
                          : EditProfileCubit.get(context).file.path.isEmpty
                              ? Image.network(
                                  HomeCubit.get(context)
                                      .userModel
                                      .user
                                      .profileImg,
                                  width: 85,
                                  height: 85,
                                  headers: DioHelper.headers(
                                      HomeCubit.get(context).userModel.token),
                                  errorBuilder: (_, __, ___) {
                                    return Image.asset(
                                      Images.defaultUserImage,
                                      height: 85,
                                      width: 85,
                                    );
                                  },
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  EditProfileCubit.get(context).file,
                                  width: 85,
                                  height: 85,
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
                        EditProfileCubit.get(context).file = File(image!.path);
                        // ignore: use_build_context_synchronously
                        await EditProfileCubit.get(context).uploadUserImage(
                            context: context,
                            image: File(image.path),
                            // ignore: use_build_context_synchronously
                            userId: HomeCubit.get(context).userModel.user.id);
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
                      mustCheck: EditProfileCubit.get(context).mustCheck,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        controller: EditProfileCubit.get(context).lastName,
                        title: Strings.lastName,
                        textInputType: TextInputType.name,
                        mustCheck: EditProfileCubit.get(context).mustCheck),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      controller: EditProfileCubit.get(context).phoneNumber,
                      title: Strings.phoneNumber,
                      textInputType: TextInputType.phone,
                      addPrefixIcon: true,
                      mustCheck: EditProfileCubit.get(context).mustCheck,
                      onlyNumbers: true,
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
                      mustCheck: EditProfileCubit.get(context).mustCheck,
                      isWrongEmail:
                          !EditProfileCubit.get(context).checkEmailValidity(),
                      errorText:
                          EditProfileCubit.get(context).email.text.isEmpty &&
                                  EditProfileCubit.get(context).mustCheck
                              ? Strings.textFieldError
                              : Strings.wrongEmail,
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
      }),
    );
  }
}
