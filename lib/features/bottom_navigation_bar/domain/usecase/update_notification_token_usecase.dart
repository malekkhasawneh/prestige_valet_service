import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/model/notification_model.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';

class UpdateNotificationTokenUseCase
    extends UseCase<NotificationModel, UpdateNotificationTokenUseCaseParams> {
  final NavRepository repository;

  UpdateNotificationTokenUseCase({required this.repository});

  @override
  Future<Either<Failures, NotificationModel>> call(
      UpdateNotificationTokenUseCaseParams params) async {
    return await repository.updateNotificationToken(
      userId: params.userId,
      token: params.token,
      tokenId: params.tokenId,
    );
  }
}

class UpdateNotificationTokenUseCaseParams extends Equatable {
  final int userId;
  final int tokenId;
  final String token;

  const UpdateNotificationTokenUseCaseParams(
      {required this.userId, required this.token, required this.tokenId});

  @override
  List<Object?> get props => [
        userId,
        token,
        tokenId,
      ];
}
