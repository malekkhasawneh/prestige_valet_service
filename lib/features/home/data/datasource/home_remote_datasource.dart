import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class HomeRemoteDataSource {
  Future<ParkedCarsModel> retrieveCar({required int parkingId});

  Future<ParkedCarsModel> washCar(
      {required int parkingId, required bool washFlag});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ParkedCarsModel> retrieveCar({required int parkingId}) async {
    try {
      await DioHelper.addTokenHeader();
      final Map<String, dynamic> response =
          await DioHelper.patch(NetworkConstants.retrieveCar(
        parkingId: parkingId,
      ));
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
}
