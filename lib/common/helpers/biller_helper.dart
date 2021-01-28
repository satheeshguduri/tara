/*
*  biller_helper.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:tara_app/models/bills/bill_product_request.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:darq/darq.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/rest/biller_rest_client.dart';
main() async
{
  print("strating the process");

  String encrypted = 'VyemMYHIQQNrLS9UEteb0vy3KId56c88dwrDoG0vywl7CDwq1aN6q8x0noEz8nQnErHhKE3tZrjWer3LjZCYVlng0v2QDDrHkJ';

// Key key = cipher.Key.fromBase64(PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
   IV iv = IV.fromSecureRandom(16);

  // var content =await Cipher2.decryptAesCbc128Padding7(encrypted, PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY,iv.toString());
//
//   cipher.Symmetry aes = cipher.Cipher.getSymmetryInstance(cipher.AES(key));
//
// var content = aes.decrypt2String(cipher.Encrypted.fromUtf8(encrypted),iv: iv);
// var decryptAESCryptoJS = PKICryptoUtils.decodeQrCode(data);
// var decryptAESCryptoJS = PKICryptoUtils().d(data, PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
//   print(content);

  // var data = await BillerHelper().getData();
  // var categories = BillerHelper().getCategories(data);
  // var billers = BillerHelper().getBillersByCategory(data,"Paket Data"); //pass the category id to get the billers
  // var products = BillerHelper().getProductsByBiller(data,"Paket Data","Telkomsel");//pass the category id and biller id to get the producsts
}


class RegistrationHelper{

  //app login

  appLogin() async{

    // CommonRegistrationRequest request = CommonRegistrationRequest();
    // await PSPRestClient(Dio()).getAppToken(PSPConfig.MERCHANT_KI, request);

  }

}
class BillerHelper{
  List<BillProductDataBean> productsList;

  Future<BillProductsResponse> getData() async {

    BillProductRequest billProductRequest  = BillProductRequest(partnerId: "ALcTM9Yrztyh");
    BillProductsResponse response = await BillerRestClient(Dio()).getBillProducts("Bearer eyJhbGciOiJIUzI1NiJ9.eyJwYXJ0bmVySWQiOiJBTGNUTTlZcnp0eWgiLCJhY2NvdW50TnVtYmVyIjoiMDgxMjMwMDAwMCIsInByb2R1Y3RDb2RlIjoiUExUSzEwIn0._BF_32r4ol5HJzNZCW5pSvfP7Vv5jgc6jbKX9dTWbcI", billProductRequest);
    return response;
  }

  //gets the distinct categories
  List<BillProductDataBean> getCategories(BillProductsResponse response){
    var categories = response.data.distinct((d)=>d.category).toList();
    print(categories.toString());
    return categories;
  }
  List<BillProductDataBean> getTypes(BillProductsResponse response){
    var types = response.data.distinct((d)=>d.type).toList();
    print(types.toString());
    return types;
  }
  List<BillProductDataBean> getCategoriesByType(BillProductsResponse response, String type){
    return response.data.where((element) => element.type == type).distinct((d)=> d.category).toList();
  }
  //gets the billers by categories
  List<BillProductDataBean> getBillersByCategory(BillProductsResponse response,  String category){
      return response.data.where((element) => element.category == category )
          .distinct((d) => d.biller)
          .toList();
  }
  //gets the products by categories
  List<BillProductDataBean> getProductsByBiller(BillProductsResponse response, String category, String biller){
    return response.data.where((element) => element.category == category && element.biller == biller).toList();
  }
}