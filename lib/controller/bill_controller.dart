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
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/biller_helper.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_product_request.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/repositories/bill_repository.dart';
import 'package:tara_app/services/rest/biller_rest_client.dart';
import 'package:tara_app/services/error/failure.dart';

import '../injector.dart';

class BillController extends GetxController{

  var showProgress = false.obs;
  var products = BillProductsResponse().obs;
  var inputField = "".obs;
  var selectedProduct = "".obs;
  var shouldShowBottomSheet = false.obs;
  var btnColor = AppColors.billerPaymentNextButtonColor.obs;
  var textStyle = TextStyles.bUTTONGrey3222.obs;
  var clickable = false.obs;
  var creditCardSelectedIndex = "-1".obs;
  var debitCardSelectedIndex = "-1".obs;


  var paymentClickable = false.obs;
  var paymentNextColor = AppColors.billerPaymentNextButtonColor.obs;
  var paymentTextStyle = TextStyles.bUTTONGrey3222.obs;


  var productDetail = BillDetailsData();

  TextEditingController phoneNumberController = TextEditingController();

  check(BillProductDataBean product,Function onComplete) async {
    showProgress.value = true;

    BillProductRequest request = BillProductRequest(partnerId: "ALcTM9Yrztyh",accountNumber: phoneNumberController.text,productCode: product.code,);
    Either<Failure,BillDetailsResponse> response = await getIt.get<BillRepository>().checkBill(request);
    showProgress.value = false;
    response.fold((l) => print, (r) => {
      productDetail = r.data,
      // shouldShowBottomSheet.value = true,
      onComplete()
    });
  }

  Future<BillProductsResponse> getData() async {
    BillProductRequest billProductRequest  = BillProductRequest(partnerId: "ALcTM9Yrztyh");
    Either<Failure,BillProductsResponse> response = await getIt.get<BillRepository>().getBillProducts(billProductRequest);
    // if(response.isRight()){
    products.value = response.getOrElse(() => null);
    return products.value;
    // }
  }
  Future getCategories() async {
    // getIt.get<()
    var data = await getData();
    return BillerHelper().getCategories(data);
  }
   List<BillProductDataBean> getBillers(BillProductDataBean categoryBean)  {
    return BillerHelper().getBillersByCategory(products.value,categoryBean.category);
  }
  List<BillProductDataBean> getProducts(BillProductDataBean billerBean)  {
    return BillerHelper().getProductsByBiller(products.value,billerBean.category,billerBean.biller);
  }


  void validateAccountNumberWidget(){

  }
  void validateCustomerIdWidget(){

  }
  void validatePhoneNumberWidget(){

  }


  // which card selected by user
  //credit card
   var isCreditCard = false.obs;
   String creditCardId;
   double creditCardAmount;
   String creditCardDesc;
   String creditCardMaskedCardNumber;




  // debit card
  var isDebitCard = false.obs;
  String mobileNumber;
  String debitCardAmount;
  String debitCardDesc;
  String debitCardBic;
  String debitCardCvv;
  num debitCardAccountId = 44;
  num debitCardBenId = 44;





}