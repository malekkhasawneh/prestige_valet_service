import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class ProfileRemoteDataSource {
  Future<User> editProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  });

  Future<bool> uploadUserImage(
      File imageFile, BuildContext context, int userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<User> editProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  }) async {
    try {
      await DioHelper.addTokenHeader();
      Map<String, dynamic> response = await DioHelper.patch(
          '${NetworkConstants.editProfile}?userId=$userId',
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "phone": phone,
            "email": email,
          });
      User userModel = User.fromJson(response);
      return userModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<bool> uploadUserImage(
      File imageFile, BuildContext context, int userId) async {
    try {
      await DioHelper.addTokenHeader();
      // ignore: use_build_context_synchronously
      return await DioHelper.uploadImage(imageFile, context, userId);
    } on Exception {
      throw ServerException();
    }
  }
}
