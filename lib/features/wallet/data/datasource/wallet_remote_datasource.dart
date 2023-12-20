import 'package:dio/dio.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<List<WalletModel>> getCards({required int userId});

  Future<MFDirectPaymentResponse> executePayment(
      {required String cardNumber,
      required String cardHolderName,
      required String expiryDate,
      required String cvv,
      required String amount});
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

  @override
  Future<MFDirectPaymentResponse> executePayment(
      {required String cardNumber,
      required String cardHolderName,
      required String expiryDate,
      required String cvv,
      required String amount}) async {
    try {
      var request = MFExecutePaymentRequest(
          paymentMethodId: 20, invoiceValue: double.parse(amount));

      var mfCardRequest = MFCard(
        cardHolderName: cardHolderName,
        number: cardNumber,
        expiryMonth: expiryDate.split('/').first,
        expiryYear: expiryDate.split('/').last,
        securityCode: cvv,
      );

      var directPaymentRequest = MFDirectPaymentRequest(
          executePaymentRequest: request, token: null, card: mfCardRequest);
      MFDirectPaymentResponse response = await MFSDK.executeDirectPayment(
          directPaymentRequest, MFLanguage.ENGLISH, (invoiceId) {});
      return response;
    } on Exception {
      throw ServerException();
    }
  }
}
