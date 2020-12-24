/*
*  dio_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tara_app/services/biller_rest_client.dart';
import 'package:tara_app/services/order_rest_client.dart';
import 'package:tara_app/services/rest_client.dart';
import 'package:tara_app/services/transaction_rest_client.dart';

import 'api.dart';

class APIHelper{
  Dio dio;
  APIHelper(){
    dio = Dio();// Provide a dio instance
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      responseBody: true,
      compact: false,
    ));
  }
  RestClient getDioClient(){
    return RestClient(dio);
  }
  OrderRestClient getDioOrderClient(){
    return OrderRestClient(dio);
  }
  TransactionRestClient getDioTransactionClient(){
    return TransactionRestClient(dio);
  }

  BillerRestClient getDioBillerClient(){
    return BillerRestClient(dio);
  }
}