import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/send_otp_model.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<SendOtpModel> sendResetPasswordOtp({required String email});

  Future<bool> verifyOtp({required String email, required String otp});

  Future<ChangePasswordModel> changePassword(
      {required String password, required String token, required String email});
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  @override
  Future<ChangePasswordModel> changePassword(
      {required String password,
      required String token,
      required String email}) async {
    try {
      Response response = await DioHelper.post(
          NetworkConstants.changePasswordEndPoint,
          data: {"email": email, "token": token, "newPassword": password});
      ChangePasswordModel changePasswordModel =
          ChangePasswordModel.fromJson(response.data);
      return changePasswordModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<SendOtpModel> sendResetPasswordOtp({required String email}) async {
    try {
      Response response = await DioHelper.post(
          NetworkConstants.sendResetPasswordOtp(email: email));
      SendOtpModel sendOtpModel = SendOtpModel.fromJson(response.data);
      return sendOtpModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      Response response =
          await DioHelper.post(NetworkConstants.verifyOtp, data: {
        "email": email,
        "token": otp,
      });
      return response.data['isVerified'] == true;
    } on Exception {
      throw ServerException();
    }
  }
}
