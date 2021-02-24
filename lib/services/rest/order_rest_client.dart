/*
*  rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/services/config/api.dart';

part 'order_rest_client.g.dart';

@RestApi(baseUrl: API.ORDER_ENDPOINT)
abstract class OrderRestClient {

  factory OrderRestClient(Dio dio,{String baseUrl}) = _OrderRestClient;

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

  ///TODO removing authorization for some time
  // Future<List<Store>> getAllStores(@Header("Authorization") String token);
  @GET(API.get_stores)
  Future<List<Store>> getAllStores();

  @GET(API.get_store_types)
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

  @GET(API.get_orders_consumers)
  Future<List<Order>> getOrdersByConsumerId(@Header("Authorization") String token, @Path() int consumerId);

  @GET(API.get_orders_merchants)
  Future<List<Order>> getOrdersByMerchantId(@Header("Authorization") String token, @Path() int merchantId);


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









}