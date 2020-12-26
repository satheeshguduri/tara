/*
*  bill_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/


import 'package:dartz/dartz.dart';
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
  var productDetail;


  void check(BillProductDataBean product) async {
    showProgress.value = true;

    BillProductRequest request = BillProductRequest(partnerId: "ALcTM9Yrztyh",accountNumber: inputField.value,productCode: product.code,);
    Either<Failure,BillDetailsResponse> response = await getIt.get<BillRepository>().checkBill(request);
    showProgress.value = false;
    response.fold((l) => print, (r) => {
      productDetail = r.data,
      shouldShowBottomSheet.value = true
    });
  }

  void validateAccountNumberWidget(){

  }
  void validateCustomerIdWidget(){

  }
  void validatePhoneNumberWidget(){

  }



}