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
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/error/server_error.dart';
import 'package:tara_app/services/rest_client.dart';

import '../injector.dart';

class AuthRepositoryImpl implements AuthRepository{

  @override
  Future<Either<Failure, BaseResponse>> getOtp(AuthRequestWithData authRequestWithData) async{
    try {
      var response = await getIt.get<RestClient>().getOTP(authRequestWithData);
      return Right(response);
    }catch(e){
      var message = ServerError(e).message;
      return Left(Failure(message:message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> login(AuthRequest authRequest) async{
    try {
      var response = await getIt.get<RestClient>().login(authRequest);
      return Right(response);
    }catch(e){
      var message = ServerError(e).message;
      return Left(Failure(message:message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> refreshToken(String test) async{
    //TODO : implement refresh token call
  }

  @override
  Future<Either<Failure, BaseResponse>> validateOtp(AuthRequestWithData authRequestWithData) async{
    try {
      var response = await getIt.get<RestClient>().validateOtp(authRequestWithData);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> signUp(SignUpRequest signUpRequest) async{
    try {
      var response = await getIt.get<RestClient>().signUp(signUpRequest);
      return Right(response);
    }catch(e){
      var message = ServerError(e).message;
      return Left(Failure(message:message));
    }
  }

}