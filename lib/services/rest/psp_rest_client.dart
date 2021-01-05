/*
*  psp_rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/register_response.dart';
import 'package:tara_app/models/core/device/token_response.dart';
import 'package:tara_app/models/core/device/track_registration_response.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/track_account_details_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_response.dart';
import 'package:tara_app/services/config/api.dart';
import 'package:tara_app/services/config/psp_config.dart';

part 'psp_rest_client.g.dart';

@RestApi(baseUrl: PSPConfig.PUBLIC_IP_PSP)
abstract class PSPRestClient {

  factory PSPRestClient(Dio dio, {String baseUrl}) = _PSPRestClient;

  //Device Registration

  @POST(PSPApi.get_token)
  @Headers(<String, dynamic>{"Content-Type": "text/plain"})
  Future<String> getAppToken(@Query("ki") String ki, @Body() String request);

  @POST(PSPApi.get_private_access_token)
  Future<TokenResponse> getPrivateAccessToken(@Body() CommonRegistrationRequest commonRegistrationRequest);

  @POST(PSPApi.register)
  Future<RegisterResponse> register(@Body() CommonRegistrationRequest commonRegistrationRequest);


  @POST(PSPApi.track_registration)
  Future<TrackRegistrationResponse> trackRegistration(@Body() CommonRegistrationRequest commonRegistrationRequest);

  // 2. Add Account
  @POST(PSPApi.customer_profile_details)
  Future<CustomerProfileDetailsResponse> getCustomerProfileDetails(@Body() CommonRegistrationRequest commonRegistrationRequest);//acquiringSource to be filled - mobile number

  @POST(PSPApi.fetch_ecosystem_bank_list)
  Future<List<BankDetailsBean>> getBanksList(@Body() CommonRegistrationRequest commonRegistrationRequest);

  @POST(PSPApi.track_account_details_request_api)
  Future<TrackAccountDetailsResponse> trackAccountDetailsRequest(@Body() CommonRegistrationRequest commonRegistrationRequest);

  /// 3. pay request
  @POST(PSPApi.pre_transaction_request)
  Future<TransactionResponse> initiatePreTransactionRequest(@Body() PreTransactionRequest preTransactionRequest);

  @POST(PSPApi.initiate_transaction_request)
  Future<TransactionResponse> initiateTransactionRequest(@Body() TransactionRequest transactionRequest);

  @POST(PSPApi.track_transaction_request)
  Future<TransactionResponse> trackTransactionRequest(@Body() TransactionRequest transactionRequest);

  @GET(PSPApi.txn_history_details)
  Future<TransactionResponse> getTxnHistory(@Body() TrackTransactionRequest transactionRequest);

///4. Merchant Pay Request




}