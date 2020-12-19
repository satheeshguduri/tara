/*
*  user_local_data_source.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class UserLocalDataStore{
  Future setUser(AuthResponse authResponse);
  void clear();
  bool isLoggedIn();
  Future<AuthResponse> getUser();
}

class UserLocalDataStoreImpl implements UserLocalDataStore{

   static const String USR_KEY= "USER";

  GetStorage storage;
  UserLocalDataStoreImpl(this.storage);

  @override
  void clear() async{
      await storage.remove(USR_KEY);
  }

  @override
  Future<AuthResponse> getUser() async{
    if(storage.hasData(USR_KEY)) {
      var data = await storage.read(USR_KEY);
      return AuthResponse.fromJson(data);
    }else{
      Future.value(AuthResponse());
    }
    //   return Right(AuthResponse.fromJson(data));
    // }else{
    //
    //   return Left(Failure(message: "User Does not Exist"));//TODO String constant
    // }
  }

  @override
  bool isLoggedIn() {
   return storage?.hasData(USR_KEY)??false;
  }

  @override
  Future setUser(AuthResponse authResponse) async{
      Get.put<AuthResponse>(authResponse);
      await storage.write(USR_KEY, authResponse.toJson());

  }
}