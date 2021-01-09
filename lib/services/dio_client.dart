/*
*  dio_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/rest/biller_rest_client.dart';
import 'package:tara_app/services/rest/order_rest_client.dart';
import 'package:tara_app/services/rest/rest_client.dart';
import 'package:tara_app/services/rest/transaction_rest_client.dart';
import 'package:tara_app/services/rest/psp_rest_client.dart';
import 'package:tara_app/services/rest/umps_core_rest_client.dart';

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
  RestClient getDioClient() => RestClient(dio);
  OrderRestClient getDioOrderClient() => OrderRestClient(dio);
  TransactionRestClient getDioTransactionClient() => TransactionRestClient(dio);
  BillerRestClient getDioBillerClient() => BillerRestClient(dio);

  Future<PSPRestClient> getSecurePSPRestClient() async{
    Dio dio = await getSecureDio();
    return PSPRestClient(dio,baseUrl: PSPConfig.PUBLIC_IP_PSP);
  }
  Future<UMPSCoreRestClient> getSecureUMPSCoreRestClient() async{
    Dio dio = await getSecureDio();
    return UMPSCoreRestClient(dio,baseUrl: PSPConfig.PUBLIC_IP_UMPS_CORE);
  }
  Future<Dio> getSecureDio() async {
    dio = new Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      responseBody: true,
      compact: false,
    ));
    SecurityContext sc = new SecurityContext(withTrustedRoots: true);
    String data = await rootBundle.loadString('assets/raw/common_crt_bkp.pem');
    List bytes = utf8.encode(data);
    sc.setTrustedCertificatesBytes(bytes);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      HttpClient httpClient = new HttpClient(context: sc);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return httpClient;
    };
    return dio;
  }
}