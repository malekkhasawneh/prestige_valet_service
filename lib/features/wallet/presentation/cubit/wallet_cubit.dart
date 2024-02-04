import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfatoorah_flutter/MFModels.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/get_cards_usecase.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  static WalletCubit get(BuildContext context) => BlocProvider.of(context);

  WalletCubit({
    required this.getCardsUseCase,
  }) : super(WalletInitial());

  final GetCardsUseCase getCardsUseCase;

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.3) - 2;

  Future<void> getCards() async {
    emit(WalletLoading());
    try {
      final response = await getCardsUseCase(NoParams());
      response.fold(
        (failure) => emit(
          WalletError(
            failure: failure.failure,
          ),
        ),
        (cards) => emit(
          WalletLoaded(model: cards),
        ),
      );
    } catch (failure) {
      emit(
        WalletError(
          failure: failure.toString(),
        ),
      );
    }
  }
}
