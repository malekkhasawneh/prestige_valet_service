import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/forget_password/domain/repository/change_password_repository.dart';

class VerifyOtpUseCase extends UseCase<bool, VerifyOtpUseCaseParams> {
  final ChangePasswordRepository repository;

  VerifyOtpUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(VerifyOtpUseCaseParams params) async {
    return await repository.verifyOtp(email: params.email, otp: params.otp);
  }
}

class VerifyOtpUseCaseParams extends Equatable {
  final String email;
  final String otp;

  const VerifyOtpUseCaseParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
