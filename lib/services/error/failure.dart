/*
*  failure.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dio/dio.dart';
import 'package:tara_app/services/error/server_error.dart';

///handle custom error and dio errors here
///yet to be done
class Failure {
  String message;

  Failure({this.message});

  Failure.fromServerError(DioError error){
    message = ServerError(error).message;
  }
}