import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/repository/profile_repository.dart';

class UploadUserImageUseCase
    extends UseCase<bool, UploadUserImageUseCaseParams> {
  final ProfileRepository repository;

  UploadUserImageUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(
      UploadUserImageUseCaseParams params) async {
    return await repository.uploadUserImage(
        params.image, params.context, params.userId);
  }
}

class UploadUserImageUseCaseParams extends Equatable {
  final int userId;
  final File image;
  final BuildContext context;

  const UploadUserImageUseCaseParams(
      {required this.userId, required this.image, required this.context});

  @override
  List<Object?> get props => [userId, image, context];
}
