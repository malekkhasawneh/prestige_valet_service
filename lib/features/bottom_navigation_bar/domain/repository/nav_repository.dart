import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/model/notification_model.dart';

abstract class NavRepository {
  Future<Either<Failures, NotificationModel>> addNotificationToken(
      {required int userId, required String token});

  Future<Either<Failures, NotificationModel>> getNotificationTokenByUserId(
      {required int userId});

  Future<Either<Failures, NotificationModel>> updateNotificationToken(
      {required int userId, required String token, required int tokenId});
  Future<Either<Failures, bool>> mustResetNotificationToken();
}
