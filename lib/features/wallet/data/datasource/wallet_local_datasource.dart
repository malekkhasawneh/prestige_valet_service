import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/database_helper.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

abstract class WalletLocalDataSource {
  Future<List<WalletModel>> getCards();
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  @override
  Future<List<WalletModel>> getCards() async {
    try {
      List<Map<String, dynamic>> response = await DatabaseHelper.getCards();
      List<WalletModel> walletModel =
          response.map((card) => WalletModel.fromJson(card)).toList();
      return walletModel;
    } on Exception {
      throw CacheException();
    }
  }
}
