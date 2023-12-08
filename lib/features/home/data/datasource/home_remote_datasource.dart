import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class HomeRemoteDataSource {
  Future<ParkedCarsModel> retrieveCar(
      {required int parkingId, required int gateId});

  Future<ParkedCarsModel> cancelCarRetrieving({required int parkingId});

  Future<ParkedCarsModel> washCar(
      {required int parkingId, required bool washFlag});

  Future<ParkHistoryModel> getUserHistory({required int userId});

  Future<bool> sendNotification({
    required String title,
    required String body,
    required String notificationType,
    required String token,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ParkedCarsModel> retrieveCar(
      {required int parkingId, required int gateId}) async {
    try {
      await DioHelper.addTokenHeader();
      final Map<String, dynamic> response = await DioHelper.patch(
          NetworkConstants.retrieveCar(parkingId: parkingId, gateId: gateId));
      ParkedCarsModel parkedCarsModel = ParkedCarsModel.fromJson(response);
      return parkedCarsModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<ParkedCarsModel> washCar(
      {required int parkingId, required bool washFlag}) async {
    try {
      await DioHelper.addTokenHeader();
      final Map<String, dynamic> response =
          await DioHelper.patch(NetworkConstants.washCar(
        parkingId: parkingId,
        washFlag: washFlag,
      ));
      ParkedCarsModel parkedCarsModel = ParkedCarsModel.fromJson(response);
      return parkedCarsModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<ParkHistoryModel> getUserHistory({required int userId}) async {
    try {
      await DioHelper.addTokenHeader();
      final Response response =
          await DioHelper.get(NetworkConstants.getUserHistory(
        userId: userId,
      ));
      ParkHistoryModel parkHistoryModel =
          ParkHistoryModel.fromJson(response.data);
      return parkHistoryModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<bool> sendNotification(
      {required String title,
      required String body,
      required String notificationType,
      required String token}) async {
    try {
      DioHelper.firebaseHeaders();
      Response response =
          await DioHelper.dio.post(NetworkConstants.sendNotification, data: {
        "notification": {"title": title, "body": body},
        "priority": "high",
        "data": {Constants.notificationDataType: notificationType},
        "to": token
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<ParkedCarsModel> cancelCarRetrieving({required int parkingId}) async {
    try {
      await DioHelper.addTokenHeader();
      final Map<String, dynamic> response = await DioHelper.patch(
          NetworkConstants.cancelCarRetrieving(parkingId: parkingId));
      ParkedCarsModel parkedCarsModel = ParkedCarsModel.fromJson(response);
      parkedCarsModel.isUserCanceled = true;
      return parkedCarsModel;
    } on Exception {
      throw ServerException();
    }
  }
}
