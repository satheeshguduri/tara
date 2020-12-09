/*
*  user_local_data_source.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class UserLocalDataStore{
  void addCustomerInfo(String object);
  void clear();
  Future<bool> isLoggedIn();
  Future<Either<Failure,CustomerProfile>> getCustomerInfo();
}

class UserLocalDataStoreImpl implements UserLocalDataStore{

  GetStorage storage;
  UserLocalDataStoreImpl(this.storage);

  @override
  void addCustomerInfo(String object) {
    // TODO: implement addCustomerInfo
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  Future<Either<Failure, CustomerProfile>> getCustomerInfo() {
    // TODO: implement getCustomerInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

}