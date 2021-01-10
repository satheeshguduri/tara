/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/common_request.dart';
import 'package:tara_app/models/core/device/common_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/models/transfer/add_beneficiary_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_response.dart';
import 'package:tara_app/models/transfer/authorize_request.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/payer_collect_request.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/refresh_otp_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/track_account_details_response.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_response.dart';
import 'package:tara_app/models/transfer/validate_mobile_request.dart';
import 'package:tara_app/models/transfer/validate_mobile_response.dart';
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest/psp_rest_client.dart';
import 'package:tara_app/services/rest/transaction_rest_client.dart';
import 'package:tara_app/services/rest/umps_core_rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/common/constants/values.dart';

import '../injector.dart';


abstract class TransactionRepository {

  Future<Either<Failure,BaseResponse>> sendMoney(TransactionModel transactionModel);
  Future<Either<Failure,BaseResponse>> updateSendRequest(TransactionModel transactionModel);

  Future<Either<Failure,List<BankDetailsBean>>> getBanksList(CommonRegistrationRequest commonRegistrationRequest);
  Future<Either<Failure,TrackAccountDetailsResponse>> trackAccountDetailsRequest(CommonRegistrationRequest commonRegistrationRequest);

  Future<Either<Failure,TransactionResponse>> initiatePreTransactionRequest(PreTransactionRequest preTransactionRequest);
  Future<Either<Failure,TransactionResponse>> initiateTransactionRequest(TransactionRequest transactionRequest);
  Future<Either<Failure,TransactionResponse>> trackTransactionRequest(TransactionRequest transactionRequest);

  Future<Either<Failure,SearchBeneficiaryResponse>> searchBeneficiary(Map<String, dynamic> queries);
  Future<Either<Failure,ValidateMobileResponse>> validateMobile(ValidateMobileRequest validateMobileRequest);
  Future<Either<Failure,AddBeneficiaryResponse>> addBeneficiary(AddBeneficiaryRequest addBeneficiaryRequest);
  Future<Either<Failure,AddBeneficiaryResponse>> mapBeneficiaryDetails(CommonRegistrationRequest commonRegistrationRequest);

  Future<Either<Failure,String>> merchantLogin(String ki, String request);

  Future<Either<Failure,TransactionResponse>> payerCollectResponse(PayerCollectRequest payerCollectRequest);

  Future<Either<Failure,TransactionHistoryResponse>> getTxnHistory(Map<String, dynamic> queries);

  Future<Either<Failure,String>> getBankLogo(Map<String, dynamic> queries);


  Future<Either<Failure,CommonResponse>> registerCardDetail(CommonRequest commonRequest);//from this extract RegisterCardResponse and pass RegisterCardRequest

  Future<Either<Failure,CommonResponse>> confirmAccountRegistration(CommonRequest commonRequest);// pass ConfirmAccountRegistrationRequest

  Future<Either<Failure,RetrieveKeyResponse>> retrieveKey(RetrieveKeyRequest retrieveKeyRequest);//from this extract RetrieveKey Response and pass RetrieveKey request

  Future<Either<Failure,CommonResponse>> authorize(AuthorizeRequest authorizeRequest);// pass ValidateOTPRequest

  Future<Either<Failure,FetchOtpResponse>> fetchOtp(FetchOtpRequest fetchOtpRequest);// pass FetchOTPRequest and extract FetchOTP Response

  Future<Either<Failure,FetchOtpResponse>> refreshOtp(RefreshOtpRequest refreshOtpRequest);// pass RefreshOTPRequest and extract FetchOTPResponse

  Future<Either<Failure,FetchOtpResponse>> validateOtp(ValidateOtpRequest validateOtpRequest);// pass ValidateOTPRequest

  Future<Either<Failure,CommonResponse>> retrieveAndAuthorize(CommonRequest commonRequest);// pass ValidateOTPRequest


}

class TransactionRepositoryImpl implements TransactionRepository{

  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  TransactionRestClient remoteDataSource;
  PSPRestClient pspRemoteDataSource;
  UMPSCoreRestClient umpsRemoteDataSource;
  String token;

  TransactionRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource,this.pspRemoteDataSource,this.umpsRemoteDataSource);

  @override
  Future<Either<Failure,BaseResponse>> sendMoney(TransactionModel transactionModel) async {
    AuthResponse user = await userLocalDataSource.getUser();

    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.sendMoney(token, transactionModel);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure,BaseResponse>> updateSendRequest(TransactionModel transactionModel) async{
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.updateSendRequest(token, transactionModel);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, AddBeneficiaryResponse>> addBeneficiary(AddBeneficiaryRequest addBeneficiaryRequest) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CommonResponse>> authorize(AuthorizeRequest commonRequest) {


  }

  @override
  Future<Either<Failure, CommonResponse>> confirmAccountRegistration(CommonRequest commonRequest) {
    // TODO: implement confirmAccountRegistration
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FetchOtpResponse>> fetchOtp(FetchOtpRequest fetchOtpRequest) {
    // TODO: implement fetchOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> getBankLogo(Map<String, dynamic> queries) {
    // TODO: implement getBankLogo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BankDetailsBean>>> getBanksList(CommonRegistrationRequest commonRegistrationRequest) {

  }

  @override
  Future<Either<Failure, TransactionHistoryResponse>> getTxnHistory(Map<String, dynamic> queries) async{

    // BaseRequestHelper().getCustomerDataQueryParam();  use this for request
    try {
      var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();

      if(!isValidSession){
        var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
        var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
        if(!initiateSessionResponse.isRight()){
          return Left(Failure(message: "Failed to initiate session"));
        }
      }
      var response = await pspRemoteDataSource.getTxnHistory(queries);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionResponse>> initiatePreTransactionRequest(PreTransactionRequest preTransactionRequest) async{
    try {
      var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();

      if(!isValidSession){
        var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
        var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
        if(!initiateSessionResponse.isRight()){
          return Left(Failure(message: "Failed to initiate session"));
        }
      }
      var response = await pspRemoteDataSource.initiatePreTransactionRequest(preTransactionRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }

  }

  @override
  Future<Either<Failure, TransactionResponse>> initiateTransactionRequest(TransactionRequest transactionRequest) async{
    try {
      var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();

      if(!isValidSession){
        var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
        var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
        if(!initiateSessionResponse.isRight()){
          return Left(Failure(message: "Failed to initiate session"));
        }
      }
      var response = await pspRemoteDataSource.initiateTransactionRequest(transactionRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, AddBeneficiaryResponse>> mapBeneficiaryDetails(CommonRegistrationRequest commonRegistrationRequest) {
    // TODO: implement mapBeneficiaryDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> merchantLogin(String ki, String request) {
    // TODO: implement merchantLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TransactionResponse>> payerCollectResponse(PayerCollectRequest payerCollectRequest) {
    // TODO: implement payerCollectResponse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FetchOtpResponse>> refreshOtp(RefreshOtpRequest commonRequest) {
    // TODO: implement refreshOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CommonResponse>> registerCardDetail(CommonRequest commonRequest) {
    // TODO: implement registerCardDetail

    var test;
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RetrieveKeyResponse>> retrieveKey(RetrieveKeyRequest retrieveKeyRequest) async{

    try{
      var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(retrieveKeyRequest.toJson()),sessionInfo.sessionKey);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(TransactionType.FINANCIAL_TXN, symmetricKey);
      var commonRequest = CommonRequest(
          commonRequest: commonRequestBean,
          credentialKeysRetrievalPayloadEnc: encryptedBody
      );
      var response = await umpsRemoteDataSource.retrieveKey(commonRequest);
      if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithSymmetricKey(response.encryptionKeyRetrievalResponsePayloadEnc, response?.commonResponse?.symmetricKey, sessionInfo.sessionKey);
        var finalResponse = RetrieveKeyResponse.fromJson(jsonDecode(decryptedBody));
        return Right(finalResponse);
      }

      return Left(Failure(message: "Something went wrong"));
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, SearchBeneficiaryResponse>> searchBeneficiary(Map<String, dynamic> queries) async{
    try {
      var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();

      if(!isValidSession){
        var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
        var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
        if(!initiateSessionResponse.isRight()){
          return Left(Failure(message: "Failed to initiate session"));
        }
      }
      var response = await pspRemoteDataSource.searchBeneficiary(queries);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TrackAccountDetailsResponse>> trackAccountDetailsRequest(CommonRegistrationRequest commonRegistrationRequest) {
    // TODO: implement trackAccountDetailsRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TransactionResponse>> trackTransactionRequest(TransactionRequest transactionRequest) {
    // TODO: implement trackTransactionRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ValidateMobileResponse>> validateMobile(ValidateMobileRequest validateMobileRequest) async{
    try {
      var isValidSession = await getIt.get<SessionLocalDataStore>().isValidSession();

      if(!isValidSession){
        var commonRegistrationRequest = await BaseRequestHelper().getCommonRegistrationRequest();
        var initiateSessionResponse = await getIt.get<DeviceRegisterRepository>().initiateSession(commonRegistrationRequest);
        if(!initiateSessionResponse.isRight()){
          return Left(Failure(message: "Failed to initiate session"));
        }
      }
      var response = await pspRemoteDataSource.validateMobile(validateMobileRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }


  }

  @override
  Future<Either<Failure, FetchOtpResponse>> validateOtp(ValidateOtpRequest commonRequest) {
    // TODO: implement validateOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CommonResponse>> retrieveAndAuthorize(CommonRequest commonRequest) {
    // TODO: implement retrieveAndAuthorize
    throw UnimplementedError();
  }
  void initiateTransaction(PreTransactionRequest request,BeneDetailBean benDetailBean){

  }

}

