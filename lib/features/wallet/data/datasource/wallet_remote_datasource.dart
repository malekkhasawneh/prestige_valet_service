import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<List<WalletModel>> getCards({required int userId});
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  @override
  Future<List<WalletModel>> getCards({required int userId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response =
          await DioHelper.get('${NetworkConstants.getCards}?userId=$userId');
      List<dynamic> cards = response.data;
      List<WalletModel> walletModel =
          cards.map((card) => WalletModel.fromJson(card)).toList();
      return walletModel;
    } on Exception {
      throw ServerException();
    }
  }
}
