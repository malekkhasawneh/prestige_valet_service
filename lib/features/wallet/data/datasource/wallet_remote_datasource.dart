import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';

abstract class WalletRemoteDataSource {
  Future<bool> sendPayment(
      {required String type,
      required String amount,
      required String currency,
      required int userId,
      required int gateId,
      required int parkingId});
}

class WalletRemoteDataSourceImpl extends WalletRemoteDataSource {
  @override
  Future<bool> sendPayment(
      {required String type,
      required String amount,
      required String currency,
      required int userId,
      required int gateId,
      required int parkingId}) async {
    try {
      log('========================================== type $type');
      log('========================================== amount $amount');
      log('========================================== currency $currency');
      log('========================================== userId $userId');
      log('========================================== gateId $gateId');
      log('========================================== parkingId $parkingId');
      Response response =
          await DioHelper.post(NetworkConstants.sendPayment, data: {
        "type": "CASH",
        "amount": 3,
        "currency": "SAU",
        "paymentDescription": "",
        "recipientEmail": "",
        "created": "2024-05-02T22:55:04.796Z",
        "userId": 102,
        "gateId": 1,
        "parkingId": parkingId
      });
      if (response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      throw ServerException();
    }
  }
}
