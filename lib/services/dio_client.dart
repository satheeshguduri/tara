/*
*  dio_client.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 nxgenpro. All rights reserved.
*/

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tara_app/services/rest_client.dart';

@Singleton()
class APIHelper{
  Dio dio;
  APIHelper(){
    dio = Dio();   // Provide a dio instance
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      responseBody: true,
      compact: true,
    ));
  }
}