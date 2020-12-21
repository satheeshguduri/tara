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
  static const ORDER_ENDPOINT = "http://107.20.4.43:9002/";
  static const TRANSACTION_ENDPOINT = "http://107.20.4.43:9000/";
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
  ///SignUP
  static const signup = "v1/tara/auth";
  ///update profile
  static const update_profile = "v1/tara/crm/customer";
  static const customer_profile = "v1/tara/crm/customer/{customerId}";

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
static const send_money = "v0.1/tara/erp/account";


}