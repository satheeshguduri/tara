/*
*  auth_repository_impl.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/services/error/failure.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{

  @override
  Future<Either<Failure, BaseResponse>> getOTP(AuthRequestWithData authRequestWithData) {

  }

  @override
  Future<Either<Failure, BaseResponse>> login(AuthRequest authRequest) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BaseResponse>> refreshToken(String test) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BaseResponse>> signUp(String test) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BaseResponse>> validateOTP(AuthRequestWithData authRequestWithData) {
    // TODO: implement validateOTP
    throw UnimplementedError();
  }

}