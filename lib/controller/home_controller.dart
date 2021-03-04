/*
*  home_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:get/get.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:async/async.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/services/config/psp_config.dart';

class HomeController extends GetxController{

 final AsyncMemoizer accountMemorizer = AsyncMemoizer();
 final AsyncMemoizer billsMemorizer = AsyncMemoizer();
 final AsyncMemoizer transactionsMemorizer = AsyncMemoizer();
 List<BankDetailsBean> bankList;
 Map<String,String> bankLogos;


 Future getBanksList() async {
   var isSessionInitiated = await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
   var deviceRegInfo = await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
   var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
   if(isSessionInitiated) {
     var commonRequest = await BaseRequestHelper().getCommonRegistrationRequest();
     var bankListR = await getIt.get<TransactionRepository>().getBanksList(commonRequest);
     if(bankListR.isRight()){
       bankList = bankListR.getOrElse(() => null);

       bankList.forEach((element) async{
         var queries = <String,dynamic>{
           "bic":element.bic,
           "appName":PSPConfig.APP_NAME,
           "accessToken": tokenResponse?.token,
           "custPSPId": deviceRegInfo?.pspIdentifier,
         };
         var logoResp = await getIt.get<TransactionRepository>().getBankLogo(queries);
         if(logoResp.isRight()){
           var logo= logoResp.getOrElse(() => null);
           print("=============== FOUND LOGO ================");
           print(logo);
           bankLogos[element.bic] = logo;

         }
         print(bankLogos.toString());
       });

     }
   }
 }

}