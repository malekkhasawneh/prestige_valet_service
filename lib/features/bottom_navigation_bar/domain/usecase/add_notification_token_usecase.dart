import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/model/notification_model.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';

class AddNotificationTokenUseCase
    extends UseCase<NotificationModel, AddNotificationTokenUseCaseParams> {
  final NavRepository repository;

  AddNotificationTokenUseCase({required this.repository});
  @override
  Future<Either<Failures, NotificationModel>> call(AddNotificationTokenUseCaseParams params)async {
   return await repository.addNotificationToken(userId: params.userId, token: params.token);
  }
}

class AddNotificationTokenUseCaseParams extends Equatable {
  final int userId;
  final String token;

  const AddNotificationTokenUseCaseParams(
      {required this.userId, required this.token});

  @override
  List<Object?> get props => [userId,token];
}
