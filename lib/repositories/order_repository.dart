/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/services/error/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure,order.Order>> findByTransactionId(String transactionId);
  Future<Either<Failure,order.Order>> findByOrderId(String OrderId);
  Future<Either<Failure,List<order.Order>>> findAllByOrderId(String id);
  Future<Either<Failure,List<order.Order>>> findAllByMerchantId(String id);



}

