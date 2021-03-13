/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/models/order_management/store/banner_data.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/orders/create_order_req.dart';
import 'package:tara_app/models/order_management/orders/create_order_res.dart';

abstract class OrderRepository {

  Future<Either<Failure,order.Order>> getOrderByOrderId(String orderId);
  Future<Either<Failure,List<order.Order>>> getOrdersByMerchantId(int merchantId);
  Future<Either<Failure,List<order.Order>>> getOrdersByConsumerId(int consumerId);
  Future<Either<Failure,CreateOrderResponse>> createOrder(CreateOrderRequest order);
  Future<Either<Failure,order.Order>> updateOrder(order.Order order);
  Future<Either<Failure,List<BannerData>>> getBanners(String storeId);
  Future<Either<Failure,List<Item>>> getItemsByCatalogue(String catalogueId);
  Future<Either<Failure,List<Category>>> getCategories();
 /* Future<Either<Failure,order.Order>> deleteOrder(String orderId);
  Future<Either<Failure,order.Order>> findOrderByMerchantId(String merchantId);
  Future<Either<Failure,order.Order>> findByTransactionId(String transactionId);*/

}

