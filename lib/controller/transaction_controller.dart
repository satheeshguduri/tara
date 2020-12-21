/*
*  transaction_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/agent/transaction_history.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';

class TransactionController extends GetxController{
  var showProgress = false.obs;

  void sendMoney(CustomerProfile to,CustomerProfile from,double amount,pop) async{

    var fromData = FromDataBean(fromContactNumber: from.mobileNumber,fromUserFirebaseId: from.firebaseId);
    var toData = ToDataBean(toContactNumber: to.mobileNumber,toUserFirebaseId: to.firebaseId);
    var optionalDataBean = OptionalDataBean(data: DataBean(transactionContext: "Payment_Request",amount: amount));
    var transactionModel=  TransactionModel(optionalData: optionalDataBean,
      fromData: fromData,
      toData: toData,
      paid: false,transactionType: "paid",
      subType: "Grocery",
      status: "INITIATED",
      transactionDate: DateTime.now().toIso8601String(),);
    showProgress.value = true;
    Either<Failure, BaseResponse> responseDa = await getIt.get<TransactionRepository>().sendMoney(transactionModel);
    showProgress.value = false;
    responseDa.fold(
          (l) => print(l.message),
          (r) => {
            pop,
          Get.to(ConversationPage(showMakeAnOrder:false,arrChats: ["chat_money_transfer_success"],custInfo: Utils().getCustomerProfile())) //YAKUB Dummy Profile
          }
    );


  }


}