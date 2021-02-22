/*
*  rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/services/config/api.dart';
import 'package:tara_app/models/transactions/payment_response.dart';



part 'transaction_rest_client.g.dart';

@RestApi(baseUrl: API.TRANSACTION_ENDPOINT)
abstract class TransactionRestClient {

  factory TransactionRestClient(Dio dio,{String baseUrl}) = _TransactionRestClient;

  @POST(API.send_money)
  Future<PaymentResponse> sendMoney(@Header("Authorization") String token,@Body() TransactionModel transactionModel);

  @PUT(API.update_tara_transaction)
  Future<PaymentResponse> updateSendRequest(@Header("Authorization") String token,@Path() String transactionId,@Body() TransactionModel transactionModel);

}