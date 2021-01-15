/*
*  bill_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/common/helpers/pki_crypto_utils.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/register_response.dart';
import 'package:tara_app/models/core/device/spl_registration_request_enc.dart';
import 'package:tara_app/models/core/device/token_response.dart';
import 'package:tara_app/models/core/device/track_registration_response.dart';
import 'package:tara_app/models/core/device/user_registration_request.dart';
import 'package:tara_app/models/core/device/user_registration_response.dart';
import 'package:tara_app/models/core/device/user_registration_txn_request.dart';
import 'package:tara_app/models/transfer/register_request.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest/psp_rest_client.dart';
import 'package:tara_app/services/rest/umps_core_rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/tara_app.dart';

import '../injector.dart';

abstract class DeviceRegisterRepository {
  Future<Either<Failure,TokenResponse>> initiateSession(CommonRegistrationRequest commonRegistrationRequest);
  Future<Either<Failure,TokenResponse>> getAppToken(CommonRegistrationRequest commonRegistrationRequest);
  Future<Either<Failure,TokenResponse>> getPrivateAccessToken(CommonRegistrationRequest commonRegistrationRequest);
  Future<Either<Failure,RegisterResponse>> register(RegisterRequest registerRequest);
  Future<Either<Failure,void>> registerUserTxn(UserRegistrationTxnRequest registerRequest);
  Future<Either<Failure,UserRegistrationResponse>> registerUser(UserRegistrationRequest userRegistrationRequest);
  Future<Either<Failure,TrackRegistrationResponse>> trackRegistration(CommonRegistrationRequest commonRegistrationRequest);
  Future<bool> checkAndInitiateSession();
}

class DeviceRegisterRepositoryImpl implements DeviceRegisterRepository{

  SessionLocalDataStore sessionLocalDataStore;
  NetworkInfo networkInfo;
  PSPRestClient pspRemoteDataSource;
  UMPSCoreRestClient umpsRemoteDataSource;

  DeviceRegisterRepositoryImpl(this.sessionLocalDataStore,this.networkInfo,this.pspRemoteDataSource,this.umpsRemoteDataSource);

  @override
  Future<Either<Failure, TokenResponse>> getAppToken(CommonRegistrationRequest commonRegistrationRequest) async{

    try {
      var encryptedBody = await CryptoHelper().encrypt(json.encode(commonRegistrationRequest.toJson()));
      var response = await pspRemoteDataSource.getAppToken(PSPConfig.MERCHANT_KI,encryptedBody);
      var decryptedResponse = await CryptoHelper().decrypt(response);
      var map = getMap(decryptedResponse);
      if(map?.isNotEmpty??false){
        var tokenResponse = TokenResponse.fromJson(map);
        if(tokenResponse?.token?.isNotEmpty??false){
         // await sessionLocalDataStore.setToken(tokenResponse);
          print("App Token response ::"+tokenResponse.toJson().toString());
          return Right(TokenResponse.fromJson(map));
        }
      }
      return Left(Failure(message: "Token Fetch Failed"));
    }catch(e){
      print(e);
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenResponse>> getPrivateAccessToken(CommonRegistrationRequest commonRegistrationRequest) async{
    try {
      var response = await pspRemoteDataSource.getPrivateAccessToken(commonRegistrationRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest registerRequest) async{
    try {
      var response = await pspRemoteDataSource.register(registerRequest);
      //save session key which will be used to encrypt the aes key in register user request
      await sessionLocalDataStore.setSessionInfo(response);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, void>> registerUserTxn(UserRegistrationTxnRequest userRegistrationTxnRequest) async{
    try {
      await umpsRemoteDataSource.registerUserTxn(userRegistrationTxnRequest);
      return Right(null);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, UserRegistrationResponse>> registerUser(UserRegistrationRequest commonRegistrationRequest) async{
    try {
      var sessionInfo = await sessionLocalDataStore.getSessionInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(commonRegistrationRequest.toJson()),sessionInfo.sessionKey,true);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
     var encryptedRequest = SplRegistrationRequestEnc(
         msgId: uuid.v1(),
        symmetricKey: symmetricKey,
        pspOrgId: PSPConfig.PSP_ORG_ID,
        splRegistrationRequestEnc:encryptedBody,
        txnId: sessionInfo.transactionId
      );
      var response = await umpsRemoteDataSource.registerUser(encryptedRequest);
      if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithSymmetricKey(response.userRegistrationResponsePayloadEnc, response?.commonResponse?.symmetricKey, sessionInfo.sessionKey,true);
        var finalResponse = UserRegistrationResponse.fromJson(getMap(decryptedBody));
        sessionLocalDataStore.setDeviceRegInfo(finalResponse);
        return Right(finalResponse);
      }
      return Left(Failure(message: "Failed to decrypt"));
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TrackRegistrationResponse>> trackRegistration(CommonRegistrationRequest commonRegistrationRequest) async{
    try {
      var response = await pspRemoteDataSource.trackRegistration(commonRegistrationRequest);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  Map<String,dynamic> getMap(String text) => jsonDecode(text);

  @override
  Future<Either<Failure, TokenResponse>> initiateSession(CommonRegistrationRequest commonRegistrationRequest) async{
    Either<Failure, TokenResponse> response = await getAppToken(commonRegistrationRequest);

    if(response.isRight()){
      var appLoginToken = response.getOrElse(() => null);
      commonRegistrationRequest.accessToken = appLoginToken.token;
      var privateAccessTokenResponse = await pspRemoteDataSource.getPrivateAccessToken(commonRegistrationRequest);
      if(privateAccessTokenResponse?.token?.isNotEmpty??false){
          await sessionLocalDataStore.setToken(privateAccessTokenResponse);
          print("privateAccessTokenResponse ==> ::"+privateAccessTokenResponse.toJson().toString());
          return Right(privateAccessTokenResponse);
      }else{
        return Left(Failure(message: "Private Token Fetch Failed"));
      }
    }else{
      return response;
    }

  }


  Future<bool> checkAndInitiateSession() async{
   var isValidSession = await sessionLocalDataStore.isValidSession();
     // var isValidSession = false;
    if(!isValidSession){
      var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
      var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
      if(initiateSessionResponse.isRight()){
        return true;
      }
    }
    return isValidSession;
  }

}