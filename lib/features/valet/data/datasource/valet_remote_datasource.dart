import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/valet/data/model/guest_price_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/retrieve_car_queue_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/valet_history_model.dart';

abstract class ValetRemoteDataSource {
  Future<ParkedCarsModel> parkCar(
      {required int valetId, required bool isGuest});

  Future<ParkedCarsModel> changeStatusToParked({required int parkingId});

  Future<ParkedCarsModel> carDelivered({required int parkingId});

  Future<ValetHistoryModel> getValetHistory({required int valetId});

  Future<String> getSlotNumber({required int valetId});

  Future<RetrieveCarQueueModel> getCarsQueue({required int valetId});

  Future<void> setCarStatusAsRetrieving(
      {required int valetId, required int parkingId});

  Future<GuestPriceModel> getGuestPrice(int valetId);
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
  Future<ValetHistoryModel> getValetHistory({required int valetId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response = await DioHelper.get(
          NetworkConstants.getValetCarHistory(valetId: valetId));
      log('=============================================== jjj ${response.data}');
      ValetHistoryModel valetHistoryModel =
      ValetHistoryModel.fromJson(response.data);
      return valetHistoryModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<String> getSlotNumber({required int valetId}) async {
    try {
      await DioHelper.addTokenHeader();
      final response =
          await DioHelper.patch(NetworkConstants.getSlotNumber(valetId));
      return response["slot"].toString();
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<RetrieveCarQueueModel> getCarsQueue({required int valetId}) async {
    try {
      await DioHelper.addTokenHeader();
      final response =
          await DioHelper.get(NetworkConstants.getCarsQueue(valetId));
      RetrieveCarQueueModel retrieveCarQueueModel =
          RetrieveCarQueueModel.fromJson(response.data);
      return retrieveCarQueueModel;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<void> setCarStatusAsRetrieving(
      {required int valetId, required int parkingId}) async {
    try {
      await DioHelper.addTokenHeader();
      await DioHelper.patch(
          NetworkConstants.setCarStatusAsRetrieving(valetId, parkingId));
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<GuestPriceModel> getGuestPrice(int valetId) async {
    try {
      await DioHelper.addTokenHeader();
      final response =
          await DioHelper.get(NetworkConstants.getGuestPrice(valetId));
      GuestPriceModel guestPriceModel = GuestPriceModel.fromJson(response.data);
      log('====================================== ppp ${guestPriceModel.price}');
      log('====================================== ppp ${guestPriceModel.currency}');
      return guestPriceModel;
    } on Exception {
      throw ServerException();
    }
  }
}
