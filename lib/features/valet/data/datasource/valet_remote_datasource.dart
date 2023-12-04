import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class ValetRemoteDataSource {
  Future<ParkedCarsModel> parkCar({required int valetId});
}

class ValetRemoteDataSourceImpl implements ValetRemoteDataSource {
  @override
  Future<ParkedCarsModel> parkCar({required int valetId}) async {
    try {
      await DioHelper.addTokenHeader();
      var result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        Response response = await DioHelper.post(NetworkConstants.parkCar,
            data: {
              "userId": int.parse(result.rawContent.split(',').last),
              "valetId": valetId
            });
        ParkedCarsModel parkedCarsModel =
            ParkedCarsModel.fromJson(response.data);
        log('=================================================== Executed');
        return parkedCarsModel;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
