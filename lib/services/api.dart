/*
*  api.dart.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


class API{
  API._();
  static const bool IS_LIVE = false;

  static const LIVE_ENDPOINT = "http://107.20.4.43:9001/";
  static const DEMO_ENDPOINT = "http://107.20.4.43:9001/";//DEMO endpoint should be replaced here

  //API Endpoint
  static const baseUrl = IS_LIVE?LIVE_ENDPOINT:DEMO_ENDPOINT;
  ///Get OTP Call
  static const get_otp = "v1/tara/auth/otp";
  ///validate OTP
  static const validate_otp = "v1/tara/auth/otp/validate";
  ///Sign in
  static const login = "v1/tara/auth/validate";
  ///SignUP
  static const signup = "v1/tara/auth";

  static const update_profile = "v1/tara/crm/customer";


}