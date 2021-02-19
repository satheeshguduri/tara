/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'dart:convert';
import 'dart:math';

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
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_response.dart';
import 'package:tara_app/models/transfer/authorize_request.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_common_request.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/fetch_otp_common_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/payer_collect_request.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/refresh_otp_request.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/models/transfer/register_card_response.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/track_account_details_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
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

  Future<Either<Failure,BaseResponse>> initiateTaraTransaction(TransactionModel transactionModel);//while initiating the transaction
  Future<Either<Failure,BaseResponse>> updateTaraTransaction(TransactionModel transactionModel);//on Successful transaction

  Future<Either<Failure,List<BankDetailsBean>>> getBanksList(CommonRegistrationRequest commonRegistrationRequest);
  Future<Either<Failure,TrackAccountDetailsResponse>> trackAccountDetailsRequest(CommonRegistrationRequest commonRegistrationRequest,TransactionType transactionType, String sessionKey,String transactionId);
  Future<Either<Failure,TrackAccountDetailsResponse>> initiateAccountDetailsRequest(AccountDetailsRequest accountDetailsRequest);

  Future<Either<Failure,TransactionResponse>> initiatePreTransactionRequest(PreTransactionRequest preTransactionRequest);
  Future<Either<Failure,TransactionResponse>> initiateTransactionRequest(TransactionRequest transactionRequest);
  Future<Either<Failure,TransactionResponse>> trackTransactionRequest(TrackTransactionRequest transactionRequest);

  Future<Either<Failure,SearchBeneficiaryResponse>> searchBeneficiary(Map<String, dynamic> queries);
  Future<Either<Failure,ValidateMobileResponse>> validateMobile(ValidateMobileRequest validateMobileRequest);
  Future<Either<Failure,AddBeneficiaryResponse>> addBeneficiary(AddBeneficiaryRequest addBeneficiaryRequest);
  Future<Either<Failure,GetBeneficiariesResponse>> getBeneficiaries(Map<String, dynamic> queries);
  Future<Either<Failure,AddBeneficiaryResponse>> mapBeneficiaryDetails(MapBeneficiaryRequest mapBeneficiaryRequest);

  Future<Either<Failure,String>> merchantLogin(String ki, String request);

  Future<Either<Failure,TransactionResponse>> payerCollectResponse(PayerCollectRequest payerCollectRequest);

  Future<Either<Failure,TransactionHistoryResponse>> getTxnHistory(Map<String, dynamic> queries);

  Future<Either<Failure,String>> getBankLogo(Map<String, dynamic> queries);

  Future<Either<Failure,RegisterCardResponse>> registerCardDetail(RegisterCardRequest registerCardRequest,String sessionKey,String txnId,String publickKey);//from this extract RegisterCardResponse and pass RegisterCardRequest

  Future<Either<Failure,CommonResponse>> confirmAccountRegistration(ConfirmAccountRegistrationRequest commonRequest,String sessionKey,String txnId);// pass ConfirmAccountRegistrationRequest

  Future<Either<Failure,RetrieveKeyResponse>> retrieveKey(RetrieveKeyRequest retrieveKeyRequest,TransactionType transactionType, String transactionId);//from this extract RetrieveKey Response and pass RetrieveKey request

  Future<Either<Failure,CommonResponse>> authorize(AuthorizeRequest authorizeRequest,TransactionType transactionType,String sessionKey,String transactionId);// pass ValidateOTPRequest

  Future<Either<Failure,FetchOtpResponse>> fetchOtp(FetchOtpRequest fetchOtpRequest,TransactionType transactionType, String sessionKey,String transactionId);// pass FetchOTPRequest and extract FetchOTP Response

  Future<Either<Failure,FetchOtpResponse>> refreshOtp(RefreshOtpRequest refreshOtpRequest,TransactionType transactionType, String sessionKey,String transactionId);// pass RefreshOTPRequest and extract FetchOTPResponse

  Future<Either<Failure,CommonResponse>> validateOtp(ValidateOtpRequest validateOtpRequest,TransactionType transactionType, String sessionKey,String transactionId);// pass ValidateOTPRequest

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
  Future<Either<Failure,BaseResponse>> initiateTaraTransaction(TransactionModel transactionModel) async {
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
  Future<Either<Failure,BaseResponse>> updateTaraTransaction(TransactionModel transactionModel) async{
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
  Future<Either<Failure, AddBeneficiaryResponse>> addBeneficiary(AddBeneficiaryRequest addBeneficiaryRequest) async{
    try {
      var response = await pspRemoteDataSource.addBeneficiary(addBeneficiaryRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> confirmAccountRegistration(ConfirmAccountRegistrationRequest confirmAccountRegistrationRequest,String sessionKey,String txnId) async{
    try{
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(confirmAccountRegistrationRequest.toJson()),sessionKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      print("SymmetricKey==>"+symmetricKey);
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(TransactionType.REGISTER_CARD_ACC_DETAIL, symmetricKey);
      commonRequestBean.txnId = txnId;
      var commonRequest = ConfirmAccountRegistrationCommonRequest(
          commonRequest: commonRequestBean,
          confirmAccountRegPayloadEnc: encryptedBody
      );
      print(jsonEncode(commonRequest.toJson()));
      var response = await umpsRemoteDataSource.confirmAccountRegistration(commonRequest);
      print(jsonEncode(response.toJson()));
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }


  @override
  Future<Either<Failure, String>> getBankLogo(Map<String, dynamic> queries) {
    // TODO: implement getBankLogo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BankDetailsBean>>> getBanksList(CommonRegistrationRequest commonRegistrationRequest) async{
    try {
      var response = await pspRemoteDataSource.getBanksList(commonRegistrationRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionHistoryResponse>> getTxnHistory(Map<String, dynamic> queries) async{

    // BaseRequestHelper().getCustomerDataQueryParam();  use this for request
    try {
      var response = await pspRemoteDataSource.getTxnHistory(queries);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionResponse>> initiatePreTransactionRequest(PreTransactionRequest preTransactionRequest) async{
    try {
      var response = await pspRemoteDataSource.initiatePreTransactionRequest(preTransactionRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }

  }

  @override
  Future<Either<Failure, TransactionResponse>> initiateTransactionRequest(TransactionRequest transactionRequest) async{
    try {
      var response = await pspRemoteDataSource.initiateTransactionRequest(transactionRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, RetrieveKeyResponse>> retrieveKey(RetrieveKeyRequest retrieveKeyRequest,TransactionType transactionType,String transactionId) async{

    try{
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(retrieveKeyRequest.toJson()),deviceRegInfo.splKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(transactionType, symmetricKey);
      commonRequestBean.txnId = transactionId;
      var commonRequest = CommonRequest(
          commonRequest: commonRequestBean,
          credentialKeysRetrievalPayloadEnc: encryptedBody
      );
      print(jsonEncode(commonRequest.toJson()));
      var response = await umpsRemoteDataSource.retrieveKey(commonRequest);
      if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithSymmetricKey(response.encryptionKeyRetrievalResponsePayloadEnc, response?.commonResponse?.symmetricKey, deviceRegInfo.splKey,false);
        var finalResponse = RetrieveKeyResponse.fromJson(jsonDecode(decryptedBody));
        return Right(finalResponse);
      }

      return Left(Failure(message: "Something went wrong"));
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> authorize(AuthorizeRequest authorizeRequest,TransactionType transactionType,String sessionKey,String transactionId) async{
    try{
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(authorizeRequest.toJson()),sessionKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(transactionType, symmetricKey);
      commonRequestBean.txnId = transactionId;
      var commonRequest = CommonRequest(
          commonRequest: commonRequestBean,
          credentialSubmissionPayloadEnc:  encryptedBody
      );
      var response = await umpsRemoteDataSource.authorize(commonRequest);
      print(jsonEncode(response));
      return Right(response);
      /*if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithPublicKey(response.registerCardDetailResponsePayloadEnc, response?.commonResponse?.symmetricKey, deviceRegInfo.splKey,false,publickKey);
        var finalResponse = RegisterCardResponse.fromJson(jsonDecode(decryptedBody));
        return Right(finalResponse);
      }*/

      return Left(Failure(message: "Something went wrong"));
    }catch(e){
      return Left(Failure.fromServerError(e));
    }

  }
  @override
  Future<Either<Failure, FetchOtpResponse>> fetchOtp(FetchOtpRequest fetchOtpRequest,TransactionType transactionType, String sessionKey,String transactionId) async{
    try{
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(fetchOtpRequest.toJson()),deviceRegInfo.splKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];

      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(transactionType, symmetricKey);
      commonRequestBean.txnId = transactionId;
      var commonRequest = FetchOtpCommonRequest(
          commonRequest: commonRequestBean,
          fetchOtpCodePayloadEnc: encryptedBody
      );
      print(jsonEncode(commonRequest.toJson()));
      var response = await umpsRemoteDataSource.fetchOtp(commonRequest);
      if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithSymmetricKey(response.fetchOtpCodeResponsePayloadEnc, response?.commonResponse?.symmetricKey, deviceRegInfo.splKey,false);
        var finalResponse = FetchOtpResponse.fromJson(jsonDecode(decryptedBody));
        return Right(finalResponse);
      }

      return Left(Failure(message: "Something went wrong"));
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, FetchOtpResponse>> refreshOtp(RefreshOtpRequest refreshOtpRequest,TransactionType transactionType, String sessionKey,String transactionId) async{
    try{
      var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(refreshOtpRequest.toJson()),sessionKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(transactionType, symmetricKey);
      commonRequestBean.txnId = transactionId;
      var commonRequest = CommonRequest(
          commonRequest: commonRequestBean,
          refreshOtpApiPayloadEnc: encryptedBody
      );
      var response = await umpsRemoteDataSource.refreshOtp(commonRequest);
      if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithSymmetricKey(response.fetchOtpCodeResponsePayloadEnc, response?.commonResponse?.symmetricKey, deviceRegInfo.splKey,false);
        var finalResponse = FetchOtpResponse.fromJson(jsonDecode(decryptedBody));
        return Right(finalResponse);
      }

      return Left(Failure(message: "Something went wrong"));
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> validateOtp(ValidateOtpRequest validateOtpRequest,TransactionType transactionType, String sessionKey,String transactionId) async{
    try{
      var sessionInfo = await getIt.get<SessionLocalDataStore>().getSessionInfo();
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(validateOtpRequest.toJson()),sessionKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(transactionType, symmetricKey);
      commonRequestBean.txnId = transactionId;
      var commonRequest = CommonRequest(
          commonRequest: commonRequestBean,
          validateOtpApiPayloadEnc: encryptedBody
      );
      var response = await umpsRemoteDataSource.validateOtp(commonRequest);
      return Right(response);
      /*if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithSymmetricKey(response.fetchOtpCodeResponsePayloadEnc, response?.commonResponse?.symmetricKey, deviceRegInfo.splKey,false);
        var finalResponse = FetchOtpResponse.fromJson(jsonDecode(decryptedBody));
        return Right(finalResponse);
      }*/

      return Left(Failure(message: "Something went wrong"));
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, RegisterCardResponse>> registerCardDetail(RegisterCardRequest registerCardRequest,String sessionKey,String txnId,String publickKey) async{
    try{
      var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var data = await CryptoHelper().encryptDataWithRandomKey(json.encode(registerCardRequest.toJson()),sessionKey,false);
      var symmetricKey  = data['symmetricKey'];
      var encryptedBody  = data['encryptedData'];
      var commonRequestBean  = await BaseRequestHelper().getCommonRequestBean(TransactionType.REGISTER_CARD_ACC_DETAIL, symmetricKey);
      commonRequestBean.txnId = txnId;
      var commonRequest = CommonRequest(
          commonRequest: commonRequestBean,
          registerCardDetailPayloadEnc:  encryptedBody
      );
      var response = await umpsRemoteDataSource.registerCardDetail(commonRequest);
      print(jsonEncode(response));
      if(response?.commonResponse?.symmetricKey?.isNotEmpty??false) {
        var decryptedBody = await CryptoHelper().decryptDataWithPublicKey(response.registerCardDetailResponsePayloadEnc, response?.commonResponse?.symmetricKey, deviceRegInfo.splKey,false,publickKey);
        var finalResponse = RegisterCardResponse.fromJson(jsonDecode(decryptedBody));
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
      var response = await pspRemoteDataSource.searchBeneficiary(queries);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TrackAccountDetailsResponse>> trackAccountDetailsRequest(CommonRegistrationRequest commonRegistrationRequest,TransactionType transactionType, String sessionKey,String transactionId) async{
    try {
      var response = await pspRemoteDataSource.trackAccountDetailsRequest(commonRegistrationRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionResponse>> trackTransactionRequest(TrackTransactionRequest transactionRequest) async{
    try {
      var response = await pspRemoteDataSource.trackTransactionRequest(transactionRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, ValidateMobileResponse>> validateMobile(ValidateMobileRequest validateMobileRequest) async{
    try {
      var response = await pspRemoteDataSource.validateMobile(validateMobileRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }


  }


  @override
  Future<Either<Failure, AddBeneficiaryResponse>> mapBeneficiaryDetails(MapBeneficiaryRequest mapBeneficiaryRequest) async{
    try {
      var response = await pspRemoteDataSource.mapBeneficiaryDetails(mapBeneficiaryRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
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
  Future<Either<Failure, CommonResponse>> retrieveAndAuthorize(CommonRequest commonRequest) {
    // TODO: implement retrieveAndAuthorize
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TrackAccountDetailsResponse>> initiateAccountDetailsRequest(AccountDetailsRequest accountDetailsRequest) async{
    try {
      var response = await pspRemoteDataSource.initiateAccountDetailsRequest(accountDetailsRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, GetBeneficiariesResponse>> getBeneficiaries(Map<String, dynamic> queries) async{
    try {
      var response = await pspRemoteDataSource.getBeneficiaries(queries);
      print(response.toString());
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

}

