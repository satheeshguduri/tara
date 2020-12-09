/*
*  rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';

import 'api.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: API.baseUrl)
abstract class RestClient {

  factory RestClient(Dio dio,{String baseUrl}) = _RestClient;

  @POST(API.get_otp)
  Future<BaseResponse> getOTP(@Body() AuthRequestWithData loginRequest);

  @POST(API.validate_otp)
  Future<BaseResponse> validateOtp(@Body() AuthRequestWithData loginRequest);

  @POST(API.signup)
  Future<AuthResponse> login(@Body() AuthRequest loginRequest);

  @POST(API.login)
  Future<AuthResponse> signUp(@Body() SignUpRequest loginRequest);


}