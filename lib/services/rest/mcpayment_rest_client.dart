/*
*  biller_rest_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tara_app/models/bills/balance_data_response.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_product_request.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/mcpayment/card_data.dart';
import 'package:tara_app/models/mcpayment/create_card_or_pay_request.dart';
import 'package:tara_app/models/mcpayment/create_card_or_payment_response.dart';
import 'package:tara_app/models/mcpayment/pay_card_request.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/services/config/api.dart';

part 'mcpayment_rest_client.g.dart';

@RestApi(baseUrl: API.MC_ENDPOINT)
abstract class McPaymentRestClient {

  factory McPaymentRestClient(Dio dio,{String baseUrl}) = _McPaymentRestClient;

  @GET(API.get_cards_by_customer_id)
  Future<List<CardData>> getCards(@Header("Authorization") String token,@Path() String customerId);

  @POST(API.create_or_pay_with_tokenized_card)
  Future<CreateCardOrPaymentResponse> createCardOrPay(@Header("Authorization") String token,@Body() CreateCardOrPayRequest createCardOrPayRequest);

  @POST(API.get_mc_payment)
  Future<CreateCardOrPaymentResponse> payWithCard(@Header("Authorization") String token,@Body() PayCardRequest payCardRequest);

  @DELETE(API.delete_tokenization_card)
  Future<BaseResponse> deleteCard(@Header("Authorization") String token,@Path() String cardToken);







}