/*
*  auth_repository_impl.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/security_token.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/common/constants/values.dart';

class AuthRepositoryImpl implements AuthRepository{
  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  RestClient remoteDataSource;
  String token;


  AuthRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse>> getOtp(AuthRequestWithData authRequestWithData) async{
    if(!await networkInfo.isConnected){
      return Left(Failure(message:"No Internet Connection"));
    }
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
      // AuthResponse user = Get.find();
      // var bearerToken = "Bearer "+user.securityToken.token.tara;
      // var response2 = await remoteDataSource.updateProfile(bearerToken, user.customerProfile);
      userLocalDataSource.setUser(response);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CustomerProfile>> getCustomerInfoByCustomerId(String customerId) async{
    try {
      AuthResponse user = Get.find();
      token = user.securityToken.token.tara.bearer();
      var response = await remoteDataSource.getCustomerInfo(token,customerId);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> updateProfile(CustomerProfile customerProfile) async{

    try {
      AuthResponse user = Get.find();
      token = user.securityToken.token.tara.bearer();
      var response = await remoteDataSource.updateProfile(token, customerProfile);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }


}