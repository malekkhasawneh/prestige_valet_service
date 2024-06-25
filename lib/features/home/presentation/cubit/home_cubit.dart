import 'dart:async';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/helpers/database_helper.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/data/model/payment_history_model.dart';
import 'package:prestige_valet_app/features/home/data/model/retrieve_car_model.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/cancel_car_retrieving_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/check_internet_connction_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/delete_firebase_account_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_parking_history_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_data_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_history_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/retrieve_car_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/wash_car_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  HomeCubit({
    required this.getUserDataUseCase,
    required this.retrieveCarUseCase,
    required this.washCarUseCase,
    required this.getUserHistoryUseCase,
    required this.cancelCarRetrievingUseCase,
    required this.deleteFirebaseAccountUseCase,
    required this.checkInternetConnectionUseCase,
    required this.getParkingHistoryUseCase,
  }) : super(HomeInitial());

  final GetUserDataUseCase getUserDataUseCase;
  final RetrieveCarUseCase retrieveCarUseCase;
  final WashCarUseCase washCarUseCase;
  final GetUserHistoryUseCase getUserHistoryUseCase;
  final CancelCarRetrievingUseCase cancelCarRetrievingUseCase;
  final DeleteFirebaseAccountUseCase deleteFirebaseAccountUseCase;
  final CheckInternetConnectionUseCase checkInternetConnectionUseCase;
  final GetParkingHistoryUseCase getParkingHistoryUseCase;



  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.3) - 2;

  late SignUpModel userModel;
  bool isUserCarParked = false;
  bool _isUserCarInRetrieve = false;

  bool get isUserCarInRetrieve => _isUserCarInRetrieve;

  set setIsUserCarInRetrieve(bool value) {
    emit(HomeLoading());
    _isUserCarInRetrieve = value;
    emit(HomeLoaded());
  }

  bool _setGate = false;

  bool get setGate => _setGate;

  set setSetGate(bool value) {
    emit(HomeLoading());
    _setGate = value;
    emit(HomeLoaded());
  }

  bool _isHistoryPage = false;

  bool get getIsHistoryPage => _isHistoryPage;

  set setIsHistoryPage(bool value) {
    emit(HomeLoading());
    _isHistoryPage = value;
    emit(HomeLoaded());
  }


  late ParkHistoryContent parkedCarModel;

  Future<void> getUserData(BuildContext context) async {
    emit(HomeLoading());
    try {
      final response = await getUserDataUseCase(NoParams());
      response.fold((failure) => emit(HomeError(failure: failure.failure)),
          (userModel) {
        this.userModel = userModel;
        log('======================================= token ${userModel.token}');
        getUserHistory(userId: userModel.user.id);
        BottomNavBarCubit.get(context).getNotificationTokenForUser(
          userId: userModel.user.id,
        );
        emit(HomeLoaded());
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> retrieveCar({required int parkingId, required int gateId}) async {
    emit(HomeLoading());
    try {
      final response = await retrieveCarUseCase(
          RetrieveCarUseCaseParams(parkingId: parkingId, gateId: gateId));
      response.fold((failure) {
        log('========================================== HEREssss ${failure.failure}');

        emit(HomeError(failure: failure.failure));
      }, (success) {
        log('========================================== HERE');
        emit(RetrieveCarLoaded(parkedCarsModel: success));
      });
    } catch (failure) {
      log('========================================== HEREssss ${failure.toString()}');

      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> washCar({required int parkingId, required bool washFlag}) async {
    emit(HomeLoading());
    try {
      final response = await washCarUseCase(
          WashCarUseCaseParams(parkingId: parkingId, washFlag: washFlag));
      response.fold((failure) => emit(HomeError(failure: failure.failure)),
          (success) {
        emit(WashCarLoaded(parkedCarsModel: success));
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> getUserHistory({
    required int userId,
  }) async {
    emit(HomeLoading());
    try {
      final response = await getUserHistoryUseCase(
          GetUserHistoryUseCaseParams(userId: userId));
      response.fold((failure) {
        emit(HomeError(failure: failure.failure));
      }, (success) {
        loop:
        for (var status in success.content) {
          if (status.parking.parkingStatus == Constants.carParked) {
            parkedCarModel = status;
            isUserCarParked = true;
            break loop;
          } else if (status.parking.parkingStatus ==
              Constants.carInRetrieving || status.parking.parkingStatus == Constants.waitingToBeRetrieving) {
            parkedCarModel = status;
            _isUserCarInRetrieve = true;
            break loop;
          }
        }
        emit(GetUserHistoryLoaded(parkHistoryModel: success));
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> cancelCarRetrieving({required int parkingId}) async {
    emit(HomeLoading());
    try {
      final response = await cancelCarRetrievingUseCase(
          CancelCarRetrievingUseCaseParams(parkingId: parkingId));
      response.fold((failure) {
        emit(HomeError(failure: failure.failure));
      }, (success) {
        emit(CancelCarRetrievingLoaded(parkedCarsModel: success));
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  bool isParkingLoading = false;
  PaymentHistoryModel? paymentHistoryModel;

  Future<void> getParkingHistory(
      {required int pageIndex, int userId = 0}) async {
    emit(GetPaymentHistoryLoading());
    isParkingLoading = true;
    try {
      final response = await getParkingHistoryUseCase(
          GetParkingHistoryUseCaseParams(
              userId: userId == 0 ? userModel.user.id : userId,
              pageIndex: pageIndex));
      response.fold((failure) {
        log('=================================== failure ${failure.failure}');

        emit(HomeError(failure: failure.failure));
      }, (success) {
        if (paymentHistoryModel == null) {
          paymentHistoryModel = success;
        } else {
          paymentHistoryModel!.content.addAll(success.content);
          log('=================================== done');
        }
        emit(GetPaymentHistoryLoaded(paymentHistoryModel: success));
      });
    } catch (failure) {
      log('=================================== failure ${failure.toString()}');
      emit(HomeError(failure: failure.toString()));
    }
    isParkingLoading = false;
  }

  bool _isLoading = false;

  bool get getIsLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    emit(ConfirmPaymentLoading());
  }

  Future<void> getAndCheckPendingPayments(BuildContext context) async {
    emit(ConfirmPaymentLoading());
    List<Map<String, dynamic>> paymentsList =
        await DatabaseHelper.getCachedValetParking(userModel.user.id);
    List<int> userIds = [];
    List<int> parkingIds = [];
    for (var payment in paymentsList) {
      parkingIds.add(int.tryParse(payment['parkingId']) ?? 0);
      userIds.add(int.tryParse(payment['userId']) ?? 0);
    }
    Set<int> uniqueUserIdsSet = userIds.toSet();
    List<int> uniqueUserIds = uniqueUserIdsSet.toList();

    for (var id in uniqueUserIds) {
      await loopUserPayment(userId: id);
    }
    _isLoading = false;
    emit(ConfirmPaymentLoaded());
    for (var history in paymentHistoryModel!.content) {
      if (parkingIds.contains(history.parkingId)) {
        AwesomeDialog(
          context: context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: Center(
            child: Text(
              Strings.payWithCashNotification(history.amount.toString(),
                  history.currency, history.parkingId.toString()).split(',').first,
              style: const TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () async {
            await DatabaseHelper.deleteCachedValetParking(history.parkingId);
            Navigator.popUntil(context,
                (route) => route.settings.name == Routes.bottomNvBarScreen);
          },
          btnOkColor: Colors.red,
        ).show();
      }
    }
  }

  Future<void> loopUserPayment({int userId = 0}) async {
    for (int i = 0; i <= 30; i++) {
      await getParkingHistory(pageIndex: i, userId: userId);
    }
  }

  Future<void> deleteFirebaseAccount() async {
    await deleteFirebaseAccountUseCase(NoParams());
  }

  Future<bool> checkInternetConnection() async {
    bool isConnected = false;
    try {
      final response = await checkInternetConnectionUseCase(NoParams());
      response.fold(
          (failure) => isConnected = false, (success) => isConnected = success);
    } catch (failure) {
      isConnected = false;
    }
    return isConnected;
  }

  Function refreshAfterConnect = () {};

  Future<void> checkInternetConnectionTimer(BuildContext context) async {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (await checkInternetConnection()) {
        timer.cancel();
        refreshAfterConnect();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        log('=============================== still not connected');
      }
    });
  }


}
