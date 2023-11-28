import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';

abstract class AddCardRemoteDataSource {
  Future<AddCardModel> addNewCard(
      {required int userId,
      required String holderName,
      required String cardNumber,
      required String month,
      required String year});
}

class AddCardRemoteDataSourceImpl implements AddCardRemoteDataSource {
  @override
  Future<AddCardModel> addNewCard(
      {required int userId,
      required String holderName,
      required String cardNumber,
      required String month,
      required String year}) async {
    try {
      await DioHelper.addTokenHeader();
      Map<String, dynamic> response =
          await DioHelper.post(NetworkConstants.addCardEndPoint(userId), data: {
        "cardNumber": cardNumber,
        "cardHolderName": holderName,
        "expiryMonth": month,
        "expiryYear": year,
      });
      AddCardModel addCardModel = AddCardModel.fromJson(response);
      return addCardModel;
    } on Exception {
      throw ServerException();
    }
  }
}
