import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/common/widgets/rounded_card_button.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/agent/transaction_history.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/bank_transfer_accounts_list.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/screens/consumer/transfer_to_tara_user.dart';
import '../../common/constants/values.dart';
import 'bills_see_all_screen.dart';
import 'common_bills_payments_list.dart';


class HomeCustomerWidget extends StatefulWidget {
  HomeCustomerWidget({Key key}) : super(key: key);

  @override
  _HomeCustomerWidgetState createState() => _HomeCustomerWidgetState();
}

class _HomeCustomerWidgetState extends BaseState<HomeCustomerWidget> {

  var myAccountArray = ["tara cash","tara reqards", "tara score"];
  var transferToArray = ["Tara\nUsers","Bank\nAccount", "E-Money", "My\nAccount"];
  var paymentOptionsArray = ["Mobile","Internet", "PLN", "BPJS"];
  var paymentOptionsIconsArray = [Assets.MOBILE_ICON,Assets.INTERNET_ICON, Assets.PLN_ICON, Assets.BJPS_ICON];

  BillController controller = Get.find<BillController>();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Container(
            height: 260,
            child: HomeTopBar(appName: "Consumer"),
          ),
          Expanded(
            child: Container(
//              margin: EdgeInsets.only(bottom: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getMyAccountsWidget(),
                   // getTransferToWidget(),
                    getBillPaymentFuture(),
                    getTransactionsWidget(),
                    Container(
                      height: 32,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getMyAccountsWidget()
  {
    return Container(
      height: 95,
      margin: EdgeInsets.only(left: 16,),
      child: Column(
        children: [
          Container(
            child: getTitleAndSeeAllText(Strings.TARA_SERVICES),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       flex: 7.5.toInt(),
            //       child: Align(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           getTranslation(Strings.MY_ACCOUNTS),
            //           textAlign: TextAlign.left,
            //           style: BaseStyles.homeScreenHeadersStyle,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 2.5.toInt(),
            //       child: Container(
            //           padding: EdgeInsets.only(top: 8,bottom: 8),
            //           child: Column(
            //             children: [
            //               Container(
            //                 margin: EdgeInsets.only(right: 16),
            //                 child: Align(
            //                   alignment: Alignment.topRight,
            //                   child: Text(
            //                     getTranslation(Strings.SEE_ALL),
            //                     textAlign: TextAlign.center,
            //                     style: BaseStyles.seeAllTextStyle,
            //                   ),
            //                 ),
            //               ),
            //               Container(
            //                 height:2 ,
            //                 margin: EdgeInsets.only(top: 4,left: 4,right: 16),
            //                 decoration: BoxDecoration(
            //                   gradient: Gradients.primaryGradient,
            //                 ),
            //               ),
            //             ],
            //           )
            //       ),
            //     ),
            //   ],
            // ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 45,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: myAccountArray.length,
                itemBuilder: (context, index) {
                  return getMyAccountsGridItem(myAccountArray[index]);
                }),
          )
        ],
      )
    );
  }

  getMyAccountsGridItem(String accountName)
  {
//    if (accountName == "tara wallet")
//    {
      return Container(
        padding: EdgeInsets.only(right: 8,top: 2,bottom: 2),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 115,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 19, 53, 86),
              borderRadius: Radii.k8pxRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 24,
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 46,
                          height: 18,
                          margin: EdgeInsets.only(left: 3),
                          child: Image.asset(
                            "assets/images/combined-shape-7.png",
                            fit: BoxFit.none,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        accountName=="tara cash"?getTranslation(Strings.cash):accountName=="tara reqards"?getTranslation(Strings.rewards):getTranslation(Strings.score),
                        textAlign: TextAlign.left,
                        style: BaseStyles.taraWalletTextStyle,
                      ),
                    ],
                  ),
                ).onTap(onPressed: (){
                  GetHelper().getDialog(content: ErrorStateInfoWidget(buttonText:"Okay",onTap:(){
                    Get.back();
                  },title:getTranslation(Strings.feature_title),desc:getTranslation(Strings.feature_sub_title),image:Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: const Color(0xffd8d8d8)
                  ))
                  ));
                }),
              ],
            ),
          ),
        ),
      );
//    }
//    else{
//
//      return InkWell(
//        onTap: (){
//          push(ConnectNewAccountSelectBank());
//        },
//        child: Container(
//          padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
//          child: DottedBorder(
//            borderType: BorderType.RRect,
//            color: Colors.grey[400],
//            strokeWidth:1.5,
//            radius: Radius.circular(8),
//            child: ClipRRect(
//              borderRadius: BorderRadius.all(Radius.circular(8)),
//              child: Container(
//                height: 30,
//                child: Row(
//                  children: [
//                    Container(
//                      width: 25,
//                      height: 25,
//                      margin: EdgeInsets.only(left: 8),
//                      child: Image.asset(
//                        "assets/images/icon-2.png",
//                        fit: BoxFit.none,
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(right: 12,left: 4),
//                      child: Text(
//                        accountName,
//                        textAlign: TextAlign.left,
//                        style: BaseStyles.myAccountItemTextStyle,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      );
//    }
  }

  getTransferToWidget()
  {
    return Container(
        height: 140,
        margin: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      getTranslation(Strings.TRANSFER_TO),
                      textAlign: TextAlign.left,
                      style:BaseStyles.homeScreenHeadersStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: transferToArray.length,
                  itemBuilder: (context, index) {
                    return getTransferToGridItem(transferToArray[index]);
                  }),
            )
          ],
        )
    );
  }

  getTransferToGridItem(String accountName)
  {
    return InkWell(
        onTap: (){
          if (accountName == "Bank\nAccount")
          {
            push(BankTransferAccountsList());
          }
          else if (accountName == "Tara\nUsers")
          {
           push(TransferToTaraUser(isFromTaraUser:true,navBarTitle: Strings.transfer_to_tara_user));
          }
          else if (accountName == "My\nAccount")
          {
            push(BankTransferNewContact(selfTransfer: true,));
          }else if (accountName == "E-Money"){
            push(TransferToTaraUser(isFromTaraUser:false,navBarTitle: Strings.transfer_to_e_money));
          }
        },
        child:Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 76,
            height: 92,
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              boxShadow: [
                Shadows.primaryShadow,
              ],
              borderRadius: Radii.k8pxRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 18, top: 8, right: 18),
                  decoration: BoxDecoration(
                    color: AppColors.accentElement,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4,left: 4,bottom: 4,right: 4),
                  child: Text(
                    accountName,
                    textAlign: TextAlign.center,
                    style: BaseStyles.transferToItemTextStyle,
                  ),
                ),
              ],
            ),
          ),

        ));
  }

  Widget getBillPaymentFuture(){
    return FutureBuilder(
      future: Get.find<BillController>().getCategories(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<BillProductDataBean> data = snapshot.data;
          var parseData = data;
          if(data.length>4) {
             parseData = data.sublist(0, 4);
          }
          return getPaymentWidget(parseData);
        }
        return BaseWidgets.getIndicator;
      },
    );

  }



  getPaymentWidget(List<BillProductDataBean> data)
  {
    return Container(
        height: 140,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left:16,top: 2),
              child: getTitleAndSeeAllText(Strings.bills),
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.map((e) => RoundedCardButton(buttonText: e.category,image: paymentOptionsIconsArray[0],onPressed: (){
                  List<BillProductDataBean> data = controller.getBillers(e);
                  Get.to(CommonBillsPaymentListView(data:data));
                },)).toList(),
              ),
            )
          ],
        )
    );
  }

  getTransactionsWidget()
  {
    return Container(
        margin: EdgeInsets.only(left: 16, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child:getTitleAndSeeAllText(Strings.TRANSACTIONS)),
            Container(
              child: ListView.builder(
                padding:EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context,index){
                  return getTransactionsItemWidget();
                },
              ),
            )
          ],
        )
    );
  }

  getTransactionsItemWidget()
  {
    return Container(
      margin: EdgeInsets.only(right: 16,top: 8),
      padding: EdgeInsets.all(8),
      height: 64,
      decoration:
      BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)
          ),
          boxShadow: [BoxShadow(
              color: const Color(0x1f000000),
              offset: Offset(0,4),
              blurRadius: 6,
              spreadRadius: 0
          ), BoxShadow(
              color: const Color(0x14000000),
              offset: Offset(0,0),
              blurRadius: 2,
              spreadRadius: 0
          )] ,
          color: AppColors.primaryBackground
      ),
      child:Center(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Rectangle
            Row(
              children: [
                Image.asset("assets/images/avatar-11.png",height: 32,width: 32,),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          "TODAY • 12:33",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemDateTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          "Andi Ruhiyat",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                    ],
                  ) ,
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                "- Rp 300.000",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTitleAndSeeAllText(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 7.5.toInt(),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              //getTranslation(Strings.TRANSACTIONS),
              getTranslation(title),
              textAlign: TextAlign.left,
              style: BaseStyles.homeScreenHeadersStyle,
            ),
          ),
        ),
        Expanded(
          flex: 2.5.toInt(),
                child: Container(
                padding: EdgeInsets.only(top: 8,bottom: 8),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          getTranslation(Strings.SEE_ALL),
                          textAlign: TextAlign.center,
                          style: BaseStyles.seeAllTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      height:2 ,
                    //  margin: EdgeInsets.only(top: 4,left: 4,right: 16),
                        margin: EdgeInsets.only(right: 16),

                      decoration: BoxDecoration(
                        gradient: Gradients.primaryGradient,
                      ),
                    ),
                  ],
                )
            ).onTap(onPressed: (){
                  if (title == Strings.MY_ACCOUNTS)
                  {
                    // push to myaccounts
                  }
                  else if (title == Strings.bills)
                  {
                     Get.to(BillsPaymentScreen());
                  }
                  else if (title == Strings.TRANSACTIONS)
                  {
                    Get.to(TransactionHistory());
                  }

             }
            ),
          ),
        ],
    );
  }
}