import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/store/banner_data.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/services/rest/order_rest_client.dart';
import 'package:tara_app/services/rest/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/order_management/orders/create_order_req.dart';
import 'package:tara_app/models/order_management/orders/create_order_res.dart';


class OrderRepositoryImpl extends OrderRepository{

  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  OrderRestClient remoteDataSource;
  String token;

  OrderRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);

  @override
  Future<Either<Failure, CreateOrderResponse>> createOrder(CreateOrderRequest order) async{
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

  @override
  Future<Either<Failure, List<BannerData>>> getBanners(String storeId) async{
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    var queries = {
      "storeId":storeId
    };

    try {
      var response = await remoteDataSource.getBanners(token, queries);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async{
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.getCategories(token);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getItemsByCatalogue(String catalogueId) async{
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    var customerId = user?.customerProfile?.id?.toString();
    if(customerId==null)
      return Left(Failure(message: "Customer Id is Required"));

    var queries = {
      "catalogueId":catalogueId,
      "customerId":customerId
    };
    try {
      var response = await remoteDataSource.getItemsByCatalogue(token, queries);
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