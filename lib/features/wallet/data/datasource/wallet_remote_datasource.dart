import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<List<WalletModel>> getCards({required int userId});

  Future<bool> executePayment();
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
  Future<bool> executePayment() async {
    try {
      var request = MFExecutePaymentRequest(
          paymentMethodId: 20, invoiceValue: double.parse('10'));

      var mfCardRequest =  MFCard(
        cardHolderName: cardHolderName,
        number: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        securityCode: securityCode,
      );

      var directPaymentRequest = MFDirectPaymentRequest(
          executePaymentRequest: request, token: null, card: mfCardRequest);
      log(directPaymentRequest as String);
      await MFSDK
          .executeDirectPayment(directPaymentRequest, MFLanguage.ENGLISH,
              (invoiceId) {
            debugPrint("-----------$invoiceId------------");
            log(invoiceId);
          })
          .then((value) => log(value as String))
          .catchError((error) => {log(error.message)});
    } on Exception {
      throw ServerException();
    }
  }
}
