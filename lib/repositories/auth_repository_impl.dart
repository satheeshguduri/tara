/*
*  auth_repository_impl.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest/psp_rest_client.dart';
import 'package:tara_app/services/rest/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/models/auth/to_address_response.dart';


import '../injector.dart';

class AuthRepositoryImpl implements AuthRepository{
  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  RestClient remoteDataSource;
  PSPRestClient pspRemoteDataSource;
  String token;


  AuthRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource,this.pspRemoteDataSource);

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
      await userLocalDataSource.setUser(response);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  Future setAuthController(response) async{
    var controller = await Get.find<AuthController>();
    controller.user.value = response;
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
      await userLocalDataSource.setUser(response);

      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CustomerProfile>> getCustomerInfoByCustomerId(String customerId) async{
    try {
//      AuthResponse user = Get.find();
//      token = user.securityToken.token.tara.bearer();
      AuthResponse user = await userLocalDataSource.getUser();
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
//      AuthResponse user = Get.find();
//      token = user.securityToken.token.tara.bearer();
      AuthResponse user = await userLocalDataSource.getUser();
      token = user.securityToken.token.tara.bearer();
      var response = await remoteDataSource.updateProfile(token, customerProfile);
      user.customerProfile = customerProfile;
      await userLocalDataSource.setUser(user);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CustomerProfileDetailsResponse>> getCustomerProfile(CommonRegistrationRequest commonRegistrationRequest) async{
    try {

      var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();

      if(!isValidSession){
        var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
        if(!initiateSessionResponse.isRight()){
          return Left(Failure(message: "Failed to initiate session"));
        }
      }
      var response = await pspRemoteDataSource.getCustomerProfileDetails(commonRegistrationRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }



  }

  @override
  Future<Either<Failure, ToAddressResponse>> getToAddress(String mobileNumber) async{
    try {
      AuthResponse user = await userLocalDataSource.getUser();
      token = user.securityToken.token.tara.bearer();
      var response = await remoteDataSource.getToAddress(token,mobileNumber);
      print(response.toString());
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CustomerProfile>> getCustomerInfoByFirebaseId(String firebaseId) async{
    try {
      AuthResponse user = await userLocalDataSource.getUser();
      token = user.securityToken.token.tara.bearer();
      var response = await remoteDataSource.getCustomerInfoByFirebaseId(token,firebaseId);
      print(response.toString());
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }


}