/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/store/banner_data.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/orders/order_request.dart';
import 'package:tara_app/models/order_management/orders/order_response.dart';

abstract class OrderRepository {

  Future<Either<Failure,OrderResponse>> getOrderByOrderId(String orderId);
  Future<Either<Failure,List<OrderResponse>>> getOrdersByMerchantId(int merchantId);
  Future<Either<Failure,List<OrderResponse>>> getOrdersByConsumerId(int consumerId);
  Future<Either<Failure,OrderResponse>> createOrder(OrderRequest order);
  Future<Either<Failure,OrderResponse>> updateOrder(OrderRequest order);
  Future<Either<Failure,List<BannerData>>> getBanners(String storeId);
  Future<Either<Failure,List<Item>>> getItemsByCatalogue(String catalogueId);
  Future<Either<Failure,List<Category>>> getCategories();
 /* Future<Either<Failure,order.Order>> deleteOrder(String orderId);
  Future<Either<Failure,order.Order>> findOrderByMerchantId(String merchantId);
  Future<Either<Failure,order.Order>> findByTransactionId(String transactionId);*/

}

