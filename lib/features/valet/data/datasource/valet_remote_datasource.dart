import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class ValetRemoteDataSource {
  Future<ParkedCarsModel> parkCar(
      {required int valetId, required bool isGuest});

  Future<ParkedCarsModel> changeStatusToParked({required int parkingId});

  Future<ParkedCarsModel> carDelivered({required int parkingId});

  Future<ParkHistoryModel> getValetHistory({required int valetId});
}

class ValetRemoteDataSourceImpl implements ValetRemoteDataSource {
  @override
  Future<ParkedCarsModel> parkCar(
      {required int valetId, required bool isGuest}) async {
    try {
      await DioHelper.addTokenHeader();
      if (!isGuest) {
        var result = await BarcodeScanner.scan();
        if (result.rawContent.isNotEmpty) {
          Response response =
              await DioHelper.post(NetworkConstants.parkCar, data: {
            "userId": int.parse(result.rawContent.split(',').last),
            "valetId": valetId,
            "carWash": false,
          });
          log('=================================================== ${response.data}');

          ParkedCarsModel parkedCarsModel =
              ParkedCarsModel.fromJson(response.data);
          log('=================================================== Executed');
          return parkedCarsModel;
        } else {
          throw ServerException();
        }
      } else {
        Response response =
            await DioHelper.post(NetworkConstants.parkCar, data: {
          "userId": 0,
          "valetId": valetId,
          "carWash": false,
        });
        ParkedCarsModel parkedCarsModel =
            ParkedCarsModel.fromJson(response.data);
        log('=================================================== Executed');
        return parkedCarsModel;
      }
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<ParkedCarsModel> changeStatusToParked({required int parkingId}) async {
    try {
      await DioHelper.addTokenHeader();
      Map<String, dynamic> response = await DioHelper.patch(
          NetworkConstants.changeParkingStatus(parkingId: parkingId));
      ParkedCarsModel parkedCarsModel = ParkedCarsModel.fromJson(response);
      return parkedCarsModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<ParkedCarsModel> carDelivered({required int parkingId}) async{
    try {
      await DioHelper.addTokenHeader();
      Map<String, dynamic> response = await DioHelper.patch(
          NetworkConstants.carDelivered(parkingId: parkingId));
      ParkedCarsModel parkedCarsModel = ParkedCarsModel.fromJson(response);
      return parkedCarsModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<ParkHistoryModel> getValetHistory({required int valetId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response = await DioHelper.get(
          NetworkConstants.getValetCarHistory(valetId: valetId));
      ParkHistoryModel valetHistoryModel =
          ParkHistoryModel.fromJson(response.data);
      return valetHistoryModel;
    } on Exception {
      throw ServerException();
    }
  }
}
