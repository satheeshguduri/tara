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
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/services/api.dart';

part 'biller_rest_client.g.dart';

@RestApi(baseUrl: API.BILLER_ENDPOINT)
abstract class BillerRestClient {

  factory BillerRestClient(Dio dio,{String baseUrl}) = _BillerRestClient;

  @POST(API.get_bill_products)
  Future<BillProductsResponse> getBillProducts(@Header("Authorization") String token,@Body() BillProductRequest billProductRequest);

  @POST(API.pay_bill)
  Future<BillDetailsResponse> payBill(@Header("Authorization") String token,@Body() BillProductRequest billProductRequest);

  @POST(API.check_bill)
  Future<BillDetailsResponse> checkBill(@Header("Authorization") String token,@Body() BillProductRequest billProductRequest);

  @POST(API.get_bill_status)
  Future<BillDetailsResponse> getBillStatus(@Header("Authorization") String token,@Body() BillProductRequest billProductRequest);

  @POST(API.get_bill_balance)
  Future<BalanceDataResponse> getBalance(@Header("Authorization") String token,@Body() BillProductRequest billProductRequest);






}