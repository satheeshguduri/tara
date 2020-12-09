/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure,BaseResponse>> getOTP(AuthRequestWithData authRequestWithData);
  Future<Either<Failure,BaseResponse>> validateOTP(AuthRequestWithData authRequestWithData);
  Future<Either<Failure,BaseResponse>> login(AuthRequest authRequest);
  Future<Either<Failure,BaseResponse>> signUp(String test);
  Future<Either<Failure,BaseResponse>> refreshToken(String test);
}

