/*
*  psp_rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/core/device/register_response.dart';
import 'package:tara_app/models/core/device/token_response.dart';
import 'package:tara_app/models/core/device/track_registration_response.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_response.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/delete_account_request.dart';
import 'package:tara_app/models/transfer/payer_collect_request.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/register_request.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/track_account_details_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_response.dart';
import 'package:tara_app/models/transfer/validate_mobile_request.dart';
import 'package:tara_app/models/transfer/validate_mobile_response.dart';
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

  @POST(PSPApi.merchant_login)
  @Headers(<String, dynamic>{"Content-Type": "text/plain"})
  Future<String> getAppTokenMerchant(
      @Query("ki") String ki, @Body() String request);

  @POST(PSPApi.get_private_access_token)
  Future<TokenResponse> getPrivateAccessToken(
      @Body() CommonRegistrationRequest commonRegistrationRequest);

  @POST(PSPApi.register)
  Future<RegisterResponse> register(@Body() RegisterRequest registerRequest);

  @POST(PSPApi.track_registration)
  Future<TrackRegistrationResponse> trackRegistration(
      @Body() CommonRegistrationRequest commonRegistrationRequest);

  // 2. Add Account
  @POST(PSPApi.fetch_ecosystem_bank_list)
  Future<List<BankDetailsBean>> getBanksList(
      @Body() CommonRegistrationRequest commonRegistrationRequest);

  @POST(PSPApi.initiate_account_details_request_api)
  Future<TrackAccountDetailsResponse> initiateAccountDetailsRequest(
      @Body() AccountDetailsRequest commonRegistrationRequest);

  @POST(PSPApi.initiate_delete_account_request_api)
  Future<TrackAccountDetailsResponse> initiateDeleteAccountRequest(
      @Body() DeleteAccountRequest deleteAccountRequest);

  @POST(PSPApi.track_delete_account_request_api)
  Future<TrackAccountDetailsResponse> trackDeleteAccountDetailsRequest(
      @Body() CommonRegistrationRequest commonRegistrationRequest);

  @POST(PSPApi.track_account_details_request_api)
  Future<TrackAccountDetailsResponse> trackAccountDetailsRequest(
      @Body() CommonRegistrationRequest commonRegistrationRequest);

  /// 3. pay request
  @POST(PSPApi.pre_transaction_request)
  Future<TransactionResponse> initiatePreTransactionRequest(
      @Body() PreTransactionRequest preTransactionRequest);

  @POST(PSPApi.initiate_transaction_request)
  Future<TransactionResponse> initiateTransactionRequest(
      @Body() TransactionRequest transactionRequest);

  @POST(PSPApi.initiate_merchant_transaction_request)
  Future<TransactionResponse> initiateMerchantTransactionRequest(
      @Body() TransactionRequest transactionRequest);

  @POST(PSPApi.track_transaction_request)
  Future<TransactionResponse> trackTransactionRequest(
      @Body() TrackTransactionRequest transactionRequest);

  ///4. Merchant Pay Request
  @POST(PSPApi.merchant_login)
  @Headers(<String, dynamic>{"Content-Type": "text/plain"})
  Future<String> merchantLogin(@Query("ki") String ki, @Body() String request);

  @POST(PSPApi.payer_collect_response)
  Future<TransactionResponse> payerCollectResponse(
      @Body() PayerCollectRequest payerCollectRequest);

  /// 5. Collect Request
  /// Has similar calls as previous.

  //6.Transaction history
  ///Query params Ex:
  //appName=com.inde.ayopop&accessToken=7b9044ee-5530-40c5-97a3-ee4046f11ab6&custPSPId=afe400b8-c89a-4391-9a9b-172d7e5e502c&requestedLocale=en
  @GET(PSPApi.txn_history_details)
  Future<TransactionHistoryResponse> getTxnHistory(
      @Queries() Map<String, dynamic> queries);

  //7.Fetch Bank logo
  ///Query params Ex:
  //bic=CENAID00001&appName=com.inde.ayopop&accessToken=5038ed5d-d5c7-42ef-8001-9735efa451ca&custPSPId=afe400b8-c89a-4391-9a9b-172d7e5e502c
  @GET(PSPApi.fetch_bank_logo)
  Future<String> getBankLogo(@Queries() Map<String, dynamic> queries);

  ///8. Fetch customer profile
  @POST(PSPApi.customer_profile_details)
  Future<CustomerProfileDetailsResponse> getCustomerProfileDetails(
      @Body()
          CommonRegistrationRequest
              commonRegistrationRequest); //acquiringSource to be filled - mobile number

  ///9 and 10. Validate mobile
  @POST(PSPApi.validate_mobile_request)
  Future<ValidateMobileResponse> validateMobile(
      @Body() ValidateMobileRequest validateMobileRequest);

  ///11. add beneficiary
  @POST(PSPApi.add_beneficiary)
  Future<AddBeneficiaryResponse> addBeneficiary(
      @Body() AddBeneficiaryRequest addBeneficiaryRequest);

  //custPSPId=31adc4b1-02f2-4924-a13f-2aee8e6845ae&appName=com.inde.ayopop&accessToken=103601d9-9414-4a87-81f5-600cb083e505
  @GET(PSPApi.get_beneficiaries)
  Future<GetBeneficiariesResponse> getBeneficiaries(
      @Queries() Map<String, dynamic> queries);

  @POST(PSPApi.map_beneficiary_detail)
  Future<AddBeneficiaryResponse> mapBeneficiaryDetails(
      @Body() MapBeneficiaryRequest mapBeneficiaryRequest);

  ///12.Get beneficiary details by account number
  ///BY Account
  ///bic=CENAID00001&accountNo=9865327410&pspId=afe400b8-c89a-4391-9a9b-172d7e5e502c&appId=com.inde.ayopop&accessToken=b3d1d681-2d2f-4b6e-abe2-9a4270d402a8
  ///BY Mobile Number
  ///mobile=9865327410&pspId=afe400b8-c89a-4391-9a9b-172d7e5e502c&appId=com.inde.ayopop&accessToken=ebf289a9-7f31-4c3d-ba81-a40e8e64a4f6
  @GET(PSPApi.search_beneficiary_detail)
  Future<SearchBeneficiaryResponse> searchBeneficiary(
      @Queries() Map<String, dynamic> queries);
}
