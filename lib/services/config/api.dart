/*
*  api.dart.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


class API{
  API._();
  static const bool IS_LIVE = false;

  static const AUTH_ENDPOINT = "http://107.20.4.43:9001/";
  static const MC_ENDPOINT = "http://107.20.4.43:9005/";
  static const ORDER_ENDPOINT = "http://107.20.4.43:9002/";
  static const TRANSACTION_ENDPOINT = "http://107.20.4.43:9000/";
  static const BILLER_ENDPOINT = "http://107.20.4.43/";
  static const LIVE_ENDPOINT = "http://107.20.4.43:9002/";
  static const DEMO_ENDPOINT = "http://107.20.4.43:9002/";//DEMO endpoint should be replaced here

  //API Endpoint
  static const baseUrl = AUTH_ENDPOINT;//IS_LIVE?LIVE_ENDPOINT:DEMO_ENDPOINT;
  ///Get OTP Call
  static const get_otp = "v1/tara/auth/otp";
  ///validate OTP
  static const validate_otp = "v1/tara/auth/otp/validate";
  ///Sign in
  static const login = "v1/tara/auth/validate";
  ///SignUp
  static const signup = "v1/tara/auth";
  ///update profile
  static const update_profile = "v1/tara/crm/customer";
  static const customer_profile = "v1/tara/crm/customer/{customerId}";
  static const customer_profile_by_firebase_id = "v1/tara/crm/customer/firebase";
  static const get_toaddress = "v1/tara/auth";

  //Order Related API's

  static const get_orders_consumers = "v0.1/tara/erp/consumer/{consumerId}/order";
  static const get_orders_merchants = "v0.1/tara/erp/merchant/{merchantId}/order";
  static const get_stores = "v0.1/tara/erp/store";
  static const create_store = "v0.1/tara/erp/store";
  static const create_owner = "v0.1/tara/erp/owner";
  static const create_order = "v0.1/tara/erp/order";
  static const update_order = "v0.1/tara/erp/order/{orderId}";
  static const get_order = "v0.1/tara/erp/order/{orderId}";
  static const get_store_types = "v0.1/tara/erp/storetype";
  static const get_banners = "v0.1/tara/erp/banner";
  static const get_items_by_catalogue = "v0.1/tara/erp/item/list";
  static const get_categories = "v0.1/tara/erp/category";
  static const get_catalogues = "v0.1/tara/erp/catalogue";




  //mc payyment
  static const create_or_pay_with_tokenized_card = "v0.1/mcpayment/request/tokenization";
  static const get_tokenization_details = "v0.1/mcpayment/detail/tokenization/{registerId}";
  static const delete_tokenization_card = "v0.1/mcpayment/delete/token/{registerId}";
  static const get_mc_payment= "v0.1/mcpayment/request/payment";
  static const get_mc_payment_by_registerId = "v0.1/mcpayment/detail/payment/{registerId}";
  static const get_cards_by_customer_id = "v0.1/mcpayment/detail/card/{customerId}";


  //Transfer API
  static const send_money = "v0.1/tara/erp/account";
  static const update_tara_transaction = "v0.1/tara/erp/account/{transactionId}";

  //BILLER API
  static const get_bill_products = "v0.1/tara/erp/ayopop/partner/products";
  static const get_bill_status = "v0.1/tara/erp/ayopop/bill/status";
  static const check_bill = "v0.1/tara/erp/ayopop/bill/check";
  static const pay_bill = "v0.1/tara/erp/ayopop/bill/payment";
  static const get_bill_balance = "v0.1/tara/erp/ayopop/partner/balance";

}

class PSPApi{
  static const get_token = "psp-umps-adaptor/umps-login/app-login";
  static const get_private_access_token = 'psp-umps-adaptor/umps-app/issue-private-access-token';
  static const baseAWSUrl = 'https://ec2-52-73-218-46.compute-1.amazonaws.com:30443';
  static const register = 'psp-umps-adaptor/umps-app/register';
  static const track_registration = 'psp-umps-adaptor/umps-app/track-registration';

  //Add account
  static const fetch_ecosystem_bank_list = 'psp-umps-adaptor/umps-app/fetch-ecosystem-banklist';
  static const initiate_account_details_request_api = 'psp-umps-adaptor/umps-app/initiate-account-details-request-api';

  static const track_account_details_request_api = 'psp-umps-adaptor/umps-app/track-account-details-request-api';

  static const pre_transaction_request = 'psp-umps-adaptor/umps-app/pre-transaction-request';
  static const initiate_transaction_request = 'psp-umps-adaptor/umps-app/initiate-transaction-request';
  static const track_transaction_request = 'psp-umps-adaptor/umps-app/track-transaction-request';
  //Merchant Pay
  static const merchant_login = "psp-umps-adaptor/umps-login/merchant-login";
  static const payer_collect_response = "psp-umps-adaptor/umps-app/payer-collect-response";

  //transaction history
  static const txn_history_details = 'psp-umps-adaptor/umps-app/txn-history-details';

  //fetch bank logo
  static const fetch_bank_logo = 'psp-umps-adaptor/umps-app/bank-logo';

  //customer profile details
  static const customer_profile_details = 'psp-umps-adaptor/umps-app/customer-profile-details';

  //validate RTP user
  static const validate_mobile_request = 'psp-umps-adaptor/umps-app/validate-mobile-request';

  //add beneficiary
  static const add_beneficiary = 'psp-umps-adaptor/umps-app/add-beneficiary';
  static const get_beneficiaries = 'psp-umps-adaptor/umps-app/get-beneficiaries';
  static const map_beneficiary_detail = 'psp-umps-adaptor/umps-app/map-beneficiary-detail';

  //Search beneficiary
  static const search_beneficiary_detail = 'psp-umps-adaptor/umps-app/search-beneficiary-detail';





  static const map_account_to_profile = 'psp-umps-adaptor/umps-app/map-account-to-profile';
}
class UMPSCoreApi{
  static const authorize = "umps-core/spl-sdk/urn:apiver:1.0/authorize";
  static const fetch_otp_challenge_code = "umps-core/spl-sdk/urn:apiver:1.0/fetch-otp-challenge-code";
  static const refresh_otp_api = "umps-core/spl-sdk/urn:apiver:1.0/refresh-otp-api";
  static const validate_otp_api = "umps-core/spl-sdk/urn:apiver:1.0/validate-otp-api";
  static const confirm_account_registration = "umps-core/spl-sdk/urn:apiver:1.0/confirm-account-registration";
  static const user_registration_txn = "umps-core/umps-sms/urn:apiver:1.0/user-registration-txn";
  static const user_registration = "umps-core/spl-sdk/urn:apiver:1.0/user-registration";
  static const retrieve_key = "umps-core/spl-sdk/urn:apiver:1.0/retrieve-key";
  static const register_card_detail = "umps-core/spl-sdk/urn:apiver:1.0/register-card-detail";
}