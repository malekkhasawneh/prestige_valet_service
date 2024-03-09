import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';

abstract class WalletRemoteDataSource {
  Future<bool> sendPayment(
      {required String type,
      required String amount,
      required int userId,
      required int gateId,
      required int parkingId});
}

class WalletRemoteDataSourceImpl extends WalletRemoteDataSource {
  @override
  Future<bool> sendPayment(
      {required String type,
      required String amount,
      required int userId,
      required int gateId,
      required int parkingId}) async {
    try {
      Response response =
          await DioHelper.post(NetworkConstants.sendPayment, data: {
        "type": type,
        "amount": amount,
        "currency": "SU",
        "paymentDescription": "",
        "recipientEmail": "",
        "created": "",
        "userId": userId,
        "gateId": gateId,
        "parkingId": parkingId
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
}
