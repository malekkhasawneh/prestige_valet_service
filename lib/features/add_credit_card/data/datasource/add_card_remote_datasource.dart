import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';

abstract class AddCardRemoteDataSource {
  Future<AddCardModel> addNewCard(
      {required int userId,
      required int walletId,
      required String holderName,
      required String cardNumber,
      required String month,
      required String year,
      required bool isFromEdit});
}

class AddCardRemoteDataSourceImpl implements AddCardRemoteDataSource {
  @override
  Future<AddCardModel> addNewCard(
      {required int userId,
      required int walletId,
      required String holderName,
      required String cardNumber,
      required String month,
      required String year,
      required bool isFromEdit}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response = !isFromEdit
          ? await DioHelper.post(NetworkConstants.addCardEndPoint(userId),
              data: {
                  "cardNumber": cardNumber,
                  "cardHolderName": holderName,
                  "expiryMonth": month,
                  "expiryYear": year,
                })
          : await DioHelper.put(
              NetworkConstants.editCardEndPoint(userId, walletId),
              data: {
                  "cardNumber": cardNumber,
                  "cardHolderName": holderName,
                  "expiryMonth": month,
                  "expiryYear": year,
                });
      AddCardModel addCardModel = AddCardModel.fromJson(response.data);
      return addCardModel;
    } on Exception {
      throw ServerException();
    }
  }
}
