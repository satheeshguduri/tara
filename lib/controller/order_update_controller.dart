
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/models/order_management/orders/order_request.dart';
import 'package:tara_app/models/order_management/orders/order_response.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/services/error/failure.dart';


class OrderUpdateController extends GetxController{

  var arrItems = List<OrderItems>().obs;
  var arrEmptyOrder = List<String>().obs;
  var textCtrls = List<TextEditingController>().obs;
  var textDeliveryCtrl = TextEditingController().obs;
  var showProgress = false.obs;
  var deliveryCharge = "".obs;
  var updatingextFields = false.obs;

  var orderMerchat = OrderResponse().obs;


 double getTotal(){
   if(deliveryCharge.value != ""){
     return getSubTotal() + double.parse(deliveryCharge.value);
   }
   return getSubTotal();
  }

  double getSubTotal(){
   var total = 0.0;
   for(int i = 0; i < arrItems.length; i++){
     var orderItem = arrItems[i];
     total += orderItem.price;
   }
   return total;
  }

  Future<Either<Failure,OrderResponse>> updateOrder(OrderRequest orderReq) async{
    showProgress.value = true;
    Either<Failure,OrderResponse> response = await getIt.get<OrderRepository>().updateOrder(orderReq);
    showProgress.value = false;
    return response;
  }
  Future<Either<Failure,OrderResponse>> getOrderByOrderId(String orderId) async{
    showProgress.value = true;
    Either<Failure,OrderResponse> response = await getIt.get<OrderRepository>().getOrderByOrderId(orderId);
    showProgress.value = false;
    response.fold(
            (l) => print(l.message),
            (r) => {
              orderMerchat.value  = r,
              arrItems.value = r.items
        });
    return response;
  }

  OrderRequest getOrderRequestFromOrderResponse(OrderResponse order){
    var createOrderRequest = OrderRequest();
    createOrderRequest.transactionId = order.transactionId;
    createOrderRequest.customerId = order.customerId;
    createOrderRequest.orderId = order.orderId;
    createOrderRequest.items = order.items;
    createOrderRequest.storeId = order.storeId.id;
    createOrderRequest.catalogueId = order.catalogueId.id;
    createOrderRequest.order_extra = order.order_extra;
    createOrderRequest.deliveryAddress = order.deliveryAddress;
    createOrderRequest.deliveryDate = order.deliveryDate; // TODO
    createOrderRequest.orderDate = order.orderDate;//TODO
    createOrderRequest.merchantId = order.merchantId;//TODO
    createOrderRequest.orderType = order.orderType;//TODO

    return createOrderRequest;
  }

}