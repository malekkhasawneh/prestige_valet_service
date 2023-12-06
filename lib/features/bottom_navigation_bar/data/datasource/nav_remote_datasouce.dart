import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/model/notification_model.dart';

abstract class NavRemoteDataSource {
  Future<NotificationContent> addNotificationToken(
      {required int userId, required String token});

  Future<NotificationModel> getNotificationTokenByUserId({required int userId});

  Future<NotificationContent> updateNotificationToken(
      {required int userId, required String token, required int tokenId});
}

class NavRemoteDataSourceImpl implements NavRemoteDataSource {
  @override
  Future<NotificationContent> addNotificationToken(
      {required int userId, required String token}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response = await DioHelper.post(
          NetworkConstants.addNotificationToken,
          data: {"userId": userId, "notificationToken": token});
      NotificationContent notificationContent =
          NotificationContent.fromJson(response.data);
      return notificationContent;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<NotificationModel> getNotificationTokenByUserId(
      {required int userId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response =
          await DioHelper.get(NetworkConstants.getNotificationToken(userId));
      NotificationModel notificationModel =
          NotificationModel.fromJson(response.data);
        return notificationModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<NotificationContent> updateNotificationToken(
      {required int userId,
      required String token,
      required int tokenId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response = await DioHelper.put(
          NetworkConstants.updateNotificationToken(tokenId),
          data: {"userId": userId, "notificationToken": token});
      NotificationContent notificationContent =
          NotificationContent.fromJson(response.data);
      return notificationContent;
    } on Exception {
      throw ServerException();
    }
  }
}