import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/pick_up/data/model/gates_model.dart';

abstract class PickUpRemoteDataSource {
  Future<GatesModel> getGates({required int locationId});
}

class PickUpRemoteDataSourceImpl implements PickUpRemoteDataSource {
  @override
  Future<GatesModel> getGates({required int locationId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response =
          await DioHelper.get(NetworkConstants.getGatesEndPoint(locationId));
      log('========================================= ${NetworkConstants.getGatesEndPoint(locationId)}');
      Map<String, dynamic> json = response.data as Map<String, dynamic>;
      GatesModel gatesModel = GatesModel.fromJson(json);
      gatesModel.content.first.isSelected = true;
      return gatesModel;
    } on Exception {
      throw ServerException();
    }
  }
}
