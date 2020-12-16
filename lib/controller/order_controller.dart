
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/store/store.dart';

import '../injector.dart';

class OrderController extends GetxController{

  var showProgress = false.obs;
  var orderList =  List<order.Order>().obs;
  var storeTypeRes = StoreTypeResponse();
  List<StoreTypeModel> storeTypesList;
  var arrStores = List<Store>().obs;
  var custInfo = CustomerProfile().obs;

  var orderItems = order.Order().obs;
  var items = List<OrderItems>().obs;

  //Example to get the orders this need to be called in future builder
  Future getMerchantOrders() async {
    showProgress.value = true;
    AuthResponse user = Get.find();
    Either<Failure,List<order.Order>> response = await getIt.get<OrderRepository>().getOrdersByMerchantId(user.customerProfile.id);
    showProgress.value = false;
    response.fold((l) => print, (r) => {
      orderList.value = r,
      print(r.toString())
    });
  }

  //Example to get the orders this need to be called in future builder
  Future getConsumerOrders() async {
    showProgress.value = true;
    AuthResponse user = Get.find();
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

  Future getCustomerInfo(String custId) async{
    showProgress.value = true;
    Either<Failure,CustomerProfile> response = await getIt.get<AuthRepository>().getCustomerInfoByCustomerId(custId);
    showProgress.value = false;
    response.fold((l) => print(l.message), (r) => {
      custInfo.value = r
    });
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

  String getStoreType(Store store){
    var storeName = "";
    for(StoreTypeModel storeType in storeTypesList){
      if(store.storeTypeId != null){
        if(store.storeTypeId.contains(storeType.id)){
          storeName = describeEnum(storeType.type);
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