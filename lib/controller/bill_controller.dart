/*
*  bill_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_product_request.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/repositories/bill_repository.dart';
import 'package:tara_app/services/error/failure.dart';

import '../injector.dart';

class BillController extends GetxController{

  var showProgress = false.obs;
  var products = BillProductsResponse().obs;
  var inputField = "".obs;
  var selectedProduct = "".obs;
  var shouldShowBottomSheet = false.obs;
  var productDetail = BillDetailsData();
  TextEditingController phoneNumberController = TextEditingController();

  check(BillProductDataBean product,VoidCallback onComplete) async {
    showProgress.value = true;

    BillProductRequest request = BillProductRequest(partnerId: "ALcTM9Yrztyh",accountNumber: phoneNumberController.text,productCode: product.code,);
    Either<Failure,BillDetailsResponse> response = await getIt.get<BillRepository>().checkBill(request);
    showProgress.value = false;
    return response.fold((l) => print, (r) => {
      productDetail = r.data,
      shouldShowBottomSheet.value = true,
      onComplete
    });
  }

  void validateAccountNumberWidget(){

  }
  void validateCustomerIdWidget(){

  }
  void validatePhoneNumberWidget(){

  }



}