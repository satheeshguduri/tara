/*
*  user_local_data_source.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/core/device/register_response.dart';
import 'package:tara_app/models/core/device/token_response.dart';
import 'package:tara_app/models/core/device/user_registration_response.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class SessionLocalDataStore{
  Future setToken(TokenResponse tokenResponse);
  void clear();
  Future<bool> isValidSession();
  Future<TokenResponse> getToken();
  Future setIdentifier(String identifier);
  Future setSessionInfo(RegisterResponse registerResponse);
  Future<String> getIdentifier();
  Future<RegisterResponse> getSessionInfo();
  Future<UserRegistrationResponse> getDeviceRegInfo();
  Future setDeviceRegInfo(UserRegistrationResponse userRegistrationResponse);
}

class SessionLocalDataStoreImpl implements SessionLocalDataStore{

   static const String TOKEN_KEY= "TOKEN_RESPONSE";
   static const String IDENTIFIER_KEY= "SPL_IDENTIFIER";
   static const String SESSION_KEY= "REGISTER_INFO";
   static const String DEVICE_REG_KEY= "DEVICE_REGISTER_INFO";

  GetStorage storage;
   SessionLocalDataStoreImpl(this.storage);

  @override
  void clear() async{
      await storage.remove(TOKEN_KEY);
  }

  @override
  Future<TokenResponse> getToken() async{
    if(storage.hasData(TOKEN_KEY)) {
      var data = await storage.read(TOKEN_KEY);
      return TokenResponse.fromJson(data);
    }else{
      return Future.value(TokenResponse());
    }
  }

  @override
  Future<bool> isValidSession() async{
    var tokenResponse = await getToken();
    if(tokenResponse.validTillMillis!=0) {
      var validityTime = DateTime.fromMillisecondsSinceEpoch(
          tokenResponse.validTillMillis);
      return DateTime.now().isBefore(validityTime);
    }
    return Future.value(false);

   // return storage?.hasData(TOKEN_KEY)??false;
  }

  @override
  Future setToken(TokenResponse tokenResponse) async{
      var controller = Get.find<AuthController>();
      // controller.user.value = authResponse;
      await storage.write(TOKEN_KEY, tokenResponse.toJson());

  }

  @override
  Future<String> getIdentifier() async{
    if(storage.hasData(IDENTIFIER_KEY)) {
      var data = await storage.read(IDENTIFIER_KEY);
      return data;
    }else{
      return Future.value();
    }
  }

  @override
  Future setIdentifier(String identifier) async{
    await storage.write(IDENTIFIER_KEY, identifier);
  }

   @override
   Future<RegisterResponse> getSessionInfo() async{
     if(storage.hasData(SESSION_KEY)) {
       var data = await storage.read(SESSION_KEY);
       return RegisterResponse.fromJson(data);
     }else{
       return Future.value();
     }
   }

   @override
   Future setSessionInfo(RegisterResponse sessionToken) async{
     await storage.write(SESSION_KEY, sessionToken.toJson());
   }

   @override
   Future<UserRegistrationResponse> getDeviceRegInfo() async{
     if(storage.hasData(DEVICE_REG_KEY)) {
       var data = await storage.read(DEVICE_REG_KEY);
       return UserRegistrationResponse.fromJson(data);
     }else{
       return Future.value();
     }
   }

   @override
   Future setDeviceRegInfo(UserRegistrationResponse userRegistrationResponse) async{
     await storage.write(DEVICE_REG_KEY, userRegistrationResponse.toJson());
   }
}