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
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/models/order_management/store/store.dart';

import 'api.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: API.baseUrl)
abstract class RestClient {

  factory RestClient(Dio dio,{String baseUrl}) = _RestClient;

  @POST(API.get_otp)
  Future<BaseResponse> getOTP(@Body() AuthRequestWithData authRequestWithData);

  @POST(API.validate_otp)
  Future<BaseResponse> validateOtp(@Body() AuthRequestWithData authRequestWithData);

  @POST(API.login)
  Future<AuthResponse> login(@Body() AuthRequest loginRequest);

  @POST(API.signup)
  Future<AuthResponse> signUp(@Body() SignUpRequest signUpRequest);

  @PUT(API.update_profile)
  Future<AuthResponse> updateProfile(@Header("Authorization") String token,@Body() CustomerProfile signUpRequest);

  //Order management API
  // createStore(Store store);
  @POST(API.create_store)
  Future<Store> createStore(@Header("Authorization") String token,@Body() Store store);

  @GET(API.get_orders_consumers)
  Future<List<Order>> getConsumerOrders(@Header("Authorization") String token,@Path() String consumerId);

  @GET(API.get_orders_merchants)
  Future<List<Order>> getMerchantOrders(@Header("Authorization") String token,@Path() String merchantId);




}