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
import 'package:tara_app/models/auth/security_token.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/models/auth/to_address_response.dart';


import '../config/api.dart';

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
  Future<BaseResponse> updateProfile(@Header("Authorization") String token, @Body() CustomerProfile updateProfileRequest);

  @GET(API.update_profile)
  Future<CustomerProfile> getNonTaraCustomerInfo(@Header("Authorization") String token, @Query("mobile_number") String mobile);

  @GET(API.customer_profile)
  Future<CustomerProfile> getCustomerInfo(@Header("Authorization") String token,@Path() String customerId);

  //Order management API
  // createStore(Store store);
  @POST(API.create_store)
  Future<Store> createStore(@Header("Authorization") String token,@Body() Store store);

  @POST(API.create_owner)
  Future<Owner> createOwner(@Header("Authorization") String token,@Body() Owner owner);

  // @POST(API.create_store)
  // Future<BaseResponse> deleteStore(@Header("Authorization") String token,@Body() String id);

  @POST(API.create_store)
  Future<Store> updateStore(@Header("Authorization") String token,@Body() Store store);

  // @POST(API.create_store)
  // Future<Store> setStatus(@Header("Authorization") String token,@Body() String storeId, String status);

  @GET(API.create_store)
  Future<List<Store>> getAllStores(@Header("Authorization") String token);

  @GET(API.create_store)
  Future<List<StoreTypeModel>> getStoreTypes(@Header("Authorization") String token);

  // @GET(API.create_store)
  // Future<Store> getStore(@Header("Authorization") String token,@Body() String storeId);



  // @GET(API.get_orders_consumers)
  // Future<List<Order>> getConsumerOrders(@Header("Authorization") String token,@Path() String consumerId);
  //
  // @GET(API.get_orders_merchants)
  // Future<List<Order>> getMerchantOrders(@Header("Authorization") String token,@Path() String merchantId);




// Orders api's
  @POST(API.create_order)
  Future<Order> createOrder(@Header("Authorization") String token,@Body() Order order);

  // @POST(API.create_order)
  // Future<Order> deleteOrder(@Header("Authorization") String token,@Body()  String orderId);

  @PUT(API.update_order)
  Future<Order> updateOrder(@Header("Authorization") String token,@Body() Order order, @Path() String orderId);

  @GET(API.get_order)
  Future<Order> getOrderByOrderId(@Header("Authorization") String token, @Path() String orderId);

//  @GET(API.get_orders_consumers)
//  Future<List<Order>> getOrdersByConsumerId(@Header("Authorization") String token, @Path() String consumerId);
//
//  @GET(API.get_orders_merchants)
//  Future<List<Order>> getOrdersByMerchantId(@Header("Authorization") String token, @Path() String merchantId);


  //
  // @GET(API.create_order)
  // Future<Order> findByTransactionId(@Header("Authorization") String token,@Body() String transactionId);
  //
  // @GET(API.create_order)
  // Future<Order> findOrderByMerchantId(@Header("Authorization") String token,@Body() String merchantId);
  //
  // @GET(API.create_order)
  // Future<List<Order>> findAllByOrderId(@Header("Authorization") String token,@Body() String orderId);


  // CATALOGUE api's

  // @GET(API.create_order)
  // Future<List<Catalogue>> getAll(@Header("Authorization") String token);

  // @GET(API.create_order)
  // Future<Catalogue> getCatalogueById(@Header("Authorization") String token,@Body() double id);

  // @GET(API.create_order)
  // Future<Catalogue> getOneById(@Header("Authorization") String token,@Body() double id);
  //
  // @GET(API.create_order)
  // Future<void> removeCatalogue(@Header("Authorization") String token,@Body() double Id);

  @GET(API.create_order)
  Future<Catalogue> saveCatalogue(@Header("Authorization") String token,@Body() Catalogue catalogue);

  @GET(API.create_order)
  Future<Catalogue> updateCatalogue(@Header("Authorization") String token,@Body() Catalogue catalogue);


  @GET(API.get_toaddress)
  Future<ToAddressResponse> getToAddress(@Header("Authorization") String token,@Query("mobile_number") String mobile);

    @GET(API.customer_profile_by_firebase_id)
    Future<CustomerProfile> getCustomerInfoByFirebaseId(@Header("Authorization") String token,@Query("firebaseId") String firebaseId);







  }