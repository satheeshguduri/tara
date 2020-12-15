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
  Future<Either<Failure,order.Order>> getOrderByOrderId(String orderId);
  Future<Either<Failure,List<order.Order>>> findAllByOrderId(String orderId);
  Future<Either<Failure,List<order.Order>>> getOrdersByMerchantId(String merchantId);
  Future<Either<Failure,List<order.Order>>> getOrdersByConsumerId(String consumerId);
  Future<Either<Failure,order.Order>> createOrder(order.Order order);
  Future<Either<Failure,order.Order>> updateOrder(order.Order order,String orderId);
  Future<Either<Failure,order.Order>> deleteOrder(String orderId);
  Future<Either<Failure,order.Order>> findOrderByMerchantId(String merchantId);

}

