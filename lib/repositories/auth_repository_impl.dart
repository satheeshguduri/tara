/*
*  auth_repository_impl.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/error/server_error.dart';
import 'package:tara_app/services/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';

class AuthRepositoryImpl implements AuthRepository{
  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  RestClient remoteDataSource;

  AuthRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse>> getOtp(AuthRequestWithData authRequestWithData) async{
    try {
      var response = await remoteDataSource.getOTP(authRequestWithData);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login(AuthRequest authRequest) async{
    try {
      var response = await remoteDataSource.login(authRequest);
      userLocalDataSource.setUser(response);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> refreshToken(String test) async{
    //TODO : implement refresh token call
  }

  @override
  Future<Either<Failure, BaseResponse>> validateOtp(AuthRequestWithData authRequestWithData) async{
    try {
      var response = await remoteDataSource.validateOtp(authRequestWithData);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signUp(SignUpRequest signUpRequest) async{
    try {
      var response = await remoteDataSource.signUp(signUpRequest);
      userLocalDataSource.setUser(response);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

}