import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/borders.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/common/widgets/rounded_card_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tara_app/screens/base/base_state.dart';

class HomeCustomerWidget extends StatefulWidget {
  HomeCustomerWidget({Key key}) : super(key: key);

  @override
  _HomeCustomerWidgetState createState() => _HomeCustomerWidgetState();
}

class _HomeCustomerWidgetState extends BaseState<HomeCustomerWidget> {

  var myAccountArray = ["tara wallet","Add Bank", "Add E-Money"];
  var transferToArray = ["Tara\nUsers","Bank\nAccount", "E-Money", "My\nAccount"];
  var paymentOptionsArray = ["Mobile","Internet", "PLN", "BPJS"];
  var paymentOptionsIconsArray = [Assets.MOBILE_ICON,Assets.INTERNET_ICON, Assets.PLN_ICON, Assets.BJPS_ICON];

  @override
  BuildContext getContext() {
    return this.context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Container(
            height: 260,
            child: HomeTopBar(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getMyAccountsWidget(),
                    getTransferToWidget(),
                    getPaymentWidget(),
                    getTransactionsWidget()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getMyAccountsWidget()
  {
    return Container(
      height: 95,
      margin: EdgeInsets.only(left: 16,),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7.5.toInt(),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "My Accounts",
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
                                Strings.SEE_ALL,
                                textAlign: TextAlign.center,
                                style: BaseStyles.seeAllTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            height:2 ,
                            margin: EdgeInsets.only(top: 4,left: 4,right: 16),
                            decoration: BoxDecoration(
                              gradient: Gradients.primaryGradient,
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
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
    if (accountName == "tara wallet")
    {
      return Container(
        padding: EdgeInsets.only(right: 8,top: 4,bottom: 4),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: 103,
            height: 40,
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
//                    Spacer(),
                      Text(
                        "Wallet",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 8.89043,
                          height: 1.33333,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else{
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.grey[400],
            strokeWidth:1.5,
          radius: Radius.circular(8),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              height: 30,
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset(
                      "assets/images/icon-2.png",
                      fit: BoxFit.none,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 12,left: 4),
                    child: Text(
                      accountName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
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
                      "Transfer to",
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
    return Align(
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
    );
  }

  getPaymentWidget()
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
                      "Payment",
                      textAlign: TextAlign.left,
                      style:BaseStyles.homeScreenHeadersStyle ,
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
                  itemCount: paymentOptionsArray.length,
                  itemBuilder: (context, index) {
                    return RoundedCardButton(buttonText: paymentOptionsArray[index],image: paymentOptionsIconsArray[index],);
                  }),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7.5.toInt(),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Transactions",
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
                                  Strings.SEE_ALL,
                                  textAlign: TextAlign.center,
                                  style: BaseStyles.seeAllTextStyle,
                                ),
                              ),
                            ),
                            Container(
                              height:2 ,
                              margin: EdgeInsets.only(top: 4,left: 4,right: 16),
                              decoration: BoxDecoration(
                                gradient: Gradients.primaryGradient,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
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
}