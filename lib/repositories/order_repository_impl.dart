import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/services/rest/order_rest_client.dart';
import 'package:tara_app/services/rest/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/auth/auth_response.dart';


class OrderRepositoryImpl extends OrderRepository{

  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  OrderRestClient remoteDataSource;
  String token;

  OrderRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);

  @override
  Future<Either<Failure, order.Order>> createOrder(order.Order order) async{
    // AuthResponse user = Get.find();
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.createOrder(token, order);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, order.Order>> getOrderByOrderId(String orderId) async{
    // AuthResponse user = Get.find();
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
     var response = await remoteDataSource.getOrderByOrderId(token, orderId);
     return Right(response);
    }catch(e){
     return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<order.Order>>> getOrdersByConsumerId(int consumerId) async{
    // AuthResponse user = Get.find();
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.getOrdersByConsumerId(token, consumerId);
      return Right(response);
    }catch(e){
     return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, List<order.Order>>> getOrdersByMerchantId(int merchantId) async{
    // AuthResponse user = Get.find();
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.getOrdersByMerchantId(token, merchantId);
     return Right(response);
    }catch(e){
     return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, order.Order>> updateOrder(order.Order order) async{
    // AuthResponse user = Get.find();
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
     var response = await remoteDataSource.updateOrder(token, order,order.orderId);
     return Right(response);
    }catch(e){
     return Left(Failure.fromServerError(e));
    }
  }
/*
  @override
  Future<Either<Failure, order.Order>> deleteOrder(String orderId) async{
    try {
      // var response = await remoteDataSource.deleteOrder(token, orderId);
      // return Right(response);
    }catch(e){
      //return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<order.Order>>> findAllByOrderId(String orderId) async{
    try {
      // var response = await remoteDataSource.findAllByOrderId(token, orderId);
      // return Right(response);
    }catch(e){
      // return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, order.Order>> findByTransactionId(String transactionId) async{
    try {
      // var response = await remoteDataSource.findByTransactionId(token, transactionId);
      // return Right(response);
    }catch(e){
      // return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, order.Order>> findOrderByMerchantId(String merchantId) async{
    try {
      // var response = await remoteDataSource.findOrderByMerchantId(token, merchantId);
      // return Right(response);
    }catch(e){
      // return Left(Failure.fromServerError(e));
    }
  }*/

}