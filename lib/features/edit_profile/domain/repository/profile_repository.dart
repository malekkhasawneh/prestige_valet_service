import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class ProfileRepository {
  Future<Either<Failures, User>> editProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  });
  Future<Either<Failures,bool>> uploadUserImage(
      File imageFile, BuildContext context, int userId);
}
