/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure,BaseResponse>> getOtp(AuthRequestWithData authRequestWithData);
  Future<Either<Failure,BaseResponse>> validateOtp(AuthRequestWithData authRequestWithData);
  Future<Either<Failure,BaseResponse>> login(AuthRequest authRequest);
  Future<Either<Failure,BaseResponse>> signUp(SignUpRequest signUpRequest);
  Future<Either<Failure,BaseResponse>> refreshToken(String test);
}

