import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';

class SendNotificationUseCase
    extends UseCase<bool, SendNotificationUseCaseParams> {
  final HomeRepository repository;

  SendNotificationUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(
      SendNotificationUseCaseParams params) async {
    return await repository.sendNotification(
      title: params.title,
      body: params.body,
      notificationType: params.notificationType,
      token: params.token,
      notificationReceiver: params.notificationReceiver,
    );
  }
}

class SendNotificationUseCaseParams extends Equatable {
  final String title;
  final String body;
  final String notificationType;
  final String notificationReceiver;
  final String token;

  const SendNotificationUseCaseParams(
      {required this.title,
      required this.body,
      required this.notificationType,
      required this.notificationReceiver,
      required this.token});

  @override
  List<Object?> get props => [
        title,
        body,
        notificationType,
        notificationReceiver,
        token,
      ];
}
