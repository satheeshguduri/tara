/*
*  server_error.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'dart:io';

import 'package:dio/dio.dart';

import 'network_exceptions.dart';

class ServerError{
  String message;
  ServerError(error){
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.CANCEL:
              message = "Request Cancelled";
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              message = "Request Timeout";
              break;
            case DioErrorType.DEFAULT:
              message = "No Internet Connection";
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              message = "Send Timeout";
              break;
            case DioErrorType.RESPONSE:
              switch (error.response.statusCode) {
                case 400:
                  message = error.response.statusMessage;
                  break;
                case 401:
                  message = getErrorMessage(NetworkExceptions.unauthorisedRequest());
                  break;
                case 403:
                  message = getErrorMessage(NetworkExceptions.unauthorisedRequest());
                  break;
                case 404:
                  message = getErrorMessage(NetworkExceptions.notFound("Not found"));
                  break;
                case 409:
                  message = getErrorMessage(NetworkExceptions.conflict());
                  break;
                case 408:
                  message = getErrorMessage(NetworkExceptions.requestTimeout());
                  break;
                case 500:
                  message = getErrorMessage(NetworkExceptions.internalServerError());
                  break;
                case 503:
                  message = getErrorMessage(NetworkExceptions.serviceUnavailable());
                  break;
                default:
                  var responseCode = error.response.statusCode;
                  message = getErrorMessage(NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  ));
              }
              break;
            case DioErrorType.SEND_TIMEOUT:
              message = getErrorMessage(NetworkExceptions.sendTimeout());
              break;
          }
        } else if (error is SocketException) {
          message = getErrorMessage(NetworkExceptions.noInternetConnection());
        } else {
          message = getErrorMessage(NetworkExceptions.unexpectedError());
        }
      } on FormatException catch (e) {
        // Helper.printError(e.toString());
        message = getErrorMessage(NetworkExceptions.formatException());
      } catch (_) {
        message =  getErrorMessage(NetworkExceptions.unexpectedError());
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        message = getErrorMessage(NetworkExceptions.unableToProcess());
      } else {
        message = getErrorMessage(NetworkExceptions.unexpectedError());
      }
    }
  }
}
String getErrorMessage(NetworkExceptions networkExceptions) {
  var errorMessage = "";
  networkExceptions.when(notImplemented: () {
    errorMessage = "Not Implemented";
  }, requestCancelled: () {
    errorMessage = "Request Cancelled";
  }, internalServerError: () {
    errorMessage = "Internal Server Error";
  }, notFound: (String reason) {
    errorMessage = reason;
  }, serviceUnavailable: () {
    errorMessage = "Service unavailable";
  }, methodNotAllowed: () {
    errorMessage = "Method Allowed";
  }, badRequest: () {
    errorMessage = "Bad request";
  }, unauthorisedRequest: () {
    errorMessage = "Unauthorised request";
  }, unexpectedError: () {
    errorMessage = "Unexpected error occurred";
  }, requestTimeout: () {
    errorMessage = "Connection request timeout";
  }, noInternetConnection: () {
    errorMessage = "No internet connection";
  }, conflict: () {
    errorMessage = "Error due to a conflict";
  }, sendTimeout: () {
    errorMessage = "Send timeout in connection with API server";
  }, unableToProcess: () {
    errorMessage = "Unable to process the data";
  }, defaultError: (String error) {
    errorMessage = error;
  }, formatException: () {
    errorMessage = "Unexpected error occurred";
  }, notAcceptable: () {
    errorMessage = "Not acceptable";
  });
  return errorMessage;

}