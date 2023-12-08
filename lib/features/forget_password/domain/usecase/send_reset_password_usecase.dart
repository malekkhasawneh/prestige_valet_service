import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/send_otp_model.dart';
import 'package:prestige_valet_app/features/forget_password/domain/repository/change_password_repository.dart';

class SendResetPasswordOtpUseCase
    extends UseCase<SendOtpModel, SendResetPasswordOtpUseCaseParams> {
  final ChangePasswordRepository repository;

  SendResetPasswordOtpUseCase({required this.repository});

  @override
  Future<Either<Failures, SendOtpModel>> call(
      SendResetPasswordOtpUseCaseParams params) async {
    return await repository.sendResetPasswordOtp(email: params.email);
  }
}

class SendResetPasswordOtpUseCaseParams extends Equatable {
  final String email;

  const SendResetPasswordOtpUseCaseParams({required this.email});

  @override
  List<Object?> get props => [email];
}
