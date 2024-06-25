import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/valet/data/model/guest_price_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/retrieve_car_queue_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/valet_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/valet_parking_types.dart';

abstract class ValetRemoteDataSource {
  Future<ParkedCarsModel> parkCar({required int valetId, required int userId,
    required int parkingTypeId, required bool isGuest});

  Future<ParkedCarsModel> changeStatusToParked({required int parkingId});

  Future<ParkedCarsModel> carDelivered({required int parkingId});

  Future<ValetHistoryModel> getValetHistory({required int valetId});

  Future<String> getSlotNumber({required int valetId});

  Future<RetrieveCarQueueModel> getCarsQueue({required int valetId});

  Future<void> setCarStatusAsRetrieving(
      {required int valetId, required int parkingId});

  Future<GuestPriceModel> getGuestPrice(int valetId);

  Future<List<ValetParkingTypes>> getValetParkingTypes(int gateId);
}

class ValetRemoteDataSourceImpl implements ValetRemoteDataSource {
  @override
  Future<ParkedCarsModel> parkCar({required int valetId,
    required int userId,
    required int parkingTypeId,
    required bool isGuest}) async {
    try {
      await DioHelper.addTokenHeader();
      if (!isGuest) {
        Map<String, dynamic> bodyMap = parkingTypeId == -1
            ? {"userId": userId, "valetId": valetId}
            : {
                "userId": userId,
                "valetId": valetId,
                "parkingTypeId": parkingTypeId,
              };
        Response response =
            await DioHelper.post(NetworkConstants.parkCar, data: bodyMap);
        ParkedCarsModel parkedCarsModel =
              ParkedCarsModel.fromJson(response.data);
          return parkedCarsModel;

      } else {
        Map<String, dynamic> bodyMap = parkingTypeId == -1
            ? {"userId": 0, "valetId": valetId}
            : {
                "userId": 0,
                "valetId": valetId,
                "parkingTypeId": parkingTypeId,
              };
        Response response =
            await DioHelper.post(NetworkConstants.parkCar, data: bodyMap);
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

  @override
  Future<List<ValetParkingTypes>> getValetParkingTypes(int gateId) async {
    try {
      await DioHelper.addTokenHeader();
      final response =
          await DioHelper.get(NetworkConstants.parkingTypes(gateId));

      List<dynamic> responseData = response.data;
      List<ValetParkingTypes> valetParkingTypesList = responseData
          .map((data) =>
              ValetParkingTypes.fromJson(data as Map<String, dynamic>))
          .toList();
      return valetParkingTypesList;
    } on Exception {
      throw ServerException();
    }
  }
}
