import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';

class SetUserModelUseCase extends UseCase<void, SetUserModelUseCaseParams> {
  final SignUpRepository repository;

  SetUserModelUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(SetUserModelUseCaseParams params) async {
    return await repository.setUserModel(userModel: params.userModel);
  }
}

class SetUserModelUseCaseParams extends Equatable {
  final String userModel;

  const SetUserModelUseCaseParams({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}
