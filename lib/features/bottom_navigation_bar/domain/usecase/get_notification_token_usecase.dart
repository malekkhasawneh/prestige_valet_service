import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/model/notification_model.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';

class GetNotificationTokenUseCase
    extends UseCase<NotificationModel, GetNotificationTokenUseCaseParams> {
  final NavRepository repository;

  GetNotificationTokenUseCase({required this.repository});
  @override
  Future<Either<Failures, NotificationModel>> call(GetNotificationTokenUseCaseParams params)async {
    return await repository.getNotificationTokenByUserId(userId: params.userId,);
  }
}

class GetNotificationTokenUseCaseParams extends Equatable {
  final int userId;
  const GetNotificationTokenUseCaseParams(
      {required this.userId});

  @override
  List<Object?> get props => [userId];
}
