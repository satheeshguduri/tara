
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as OrderModel;

import '../injector.dart';

class OrderController extends GetxController{

  var showProgress = false.obs;
  var orderList =  List<order.Order>().obs;
//  var storeTypeRes = StoreTypeResponse();
  List<StoreTypeModel> storeTypesList;
  var arrStores = List<Store>().obs;
  // for create order
  var items = List<OrderItems>().obs;


  //Example to get the orders this need to be called in future builder
  Future getMerchantOrders() async {
    showProgress.value = true;
    AuthResponse user = await getIt.get<UserLocalDataStore>().getUser();
    Either<Failure,List<order.Order>> response = await getIt.get<OrderRepository>().getOrdersByMerchantId(user.customerProfile.id);
    showProgress.value = false;
    response.fold((l) => print, (r) => {
      orderList.value = r,
    });

  }

  //Example to get the orders this need to be called in future builder
  Future getConsumerOrders() async {
    showProgress.value = true;
    AuthResponse user = await getIt.get<UserLocalDataStore>().getUser(); //Get.find();
    Either<Failure,List<order.Order>> response = await getIt.get<OrderRepository>().getOrdersByConsumerId(user.customerProfile.id);
    showProgress.value = false;
    response.fold((l) => print, (r) => {
      orderList.value = r,
      print(r.toString())
    });
  }

  Future getAllStore() async{
    showProgress.value = true;
    Either<Failure,List<Store>> response = await getIt.get<StoresRepository>().getAllStores();
    showProgress.value = false;
    response.fold((l) => print(l.message), (r) => {
      arrStores.value = r,
    });
  }

  Future<Either<Failure,CustomerProfile>> getCustomerInfo(String custId) async{
    showProgress.value = true;
    Either<Failure,CustomerProfile> response = await getIt.get<AuthRepository>().getCustomerInfoByCustomerId(custId);
    showProgress.value = false;
//    response.fold((l) => print(l.message), (r) => {
//    });
  return response;
  }


  Future<Either<Failure,order.Order>> createOrder(order.Order orderReq) async{
    showProgress.value = true;
    Either<Failure,order.Order> response = await getIt.get<OrderRepository>().createOrder(orderReq);
    showProgress.value = false;
//    response.fold((l) => print(l.message), (r) => {
//
//    });
  return response;
  }
//  Future getOrderByOrderId(String orderId) async{
//    showProgress.value = true;
//    Either<Failure,OrderModel.Order> response = await getIt.get<OrderRepository>().getOrderByOrderId(orderId);
//    showProgress.value = false;
//    response.fold((l) => print(l.message), (r) => {
////        arrItems.value = r.items,
//    });
//
//  }

  String getStoreType(Store store){
    var storeName = "";
    for(StoreTypeModel storeType in storeTypesList){
      if(store.storeTypeId != null){
        if(store.storeTypeId.contains(storeType.id)){
          storeName = storeType.type;
        }
//        for(int id in store.storeTypeId){
//          if(id == storeType.id){
//            storeName += storeType.type.toString() + ",";
//          }
//        }
      }

    }
    return storeName;
  }
}