/*
*  stores_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/services/error/failure.dart';

abstract class StoresRepository{
  Future<Either<Failure,List<Store>>> getAllStores();
  Future<Either<Failure,Store>> createStore(Store store);
  Future<Either<Failure,Store>> updateStore(Store store);
  Future<Either<Failure,BaseResponse>> deleteStore(String id);
  Future<Either<Failure,Store>> getStore(String storeId);
  Future<Either<Failure,Store>> setStatus(String storeId,String status);
}