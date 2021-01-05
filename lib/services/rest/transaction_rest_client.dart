/*
*  rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/services/config/api.dart';

part 'transaction_rest_client.g.dart';

@RestApi(baseUrl: API.TRANSACTION_ENDPOINT)
abstract class TransactionRestClient {

  factory TransactionRestClient(Dio dio,{String baseUrl}) = _TransactionRestClient;

  @POST(API.send_money)
  Future<BaseResponse> sendMoney(@Header("Authorization") String token,@Body() TransactionModel transactionModel);

  @PUT(API.send_money)
  Future<BaseResponse> updateSendRequest(@Header("Authorization") String token,@Body() TransactionModel transactionModel);

}