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
import 'package:tara_app/common/widgets/rounded_button.dart';
import 'package:tara_app/common/widgets/rounded_card_button.dart';
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
  var paymentOptionsIconsArray = [Assets.SEND_ICON,Assets.RECEIVE_ICON, Assets.ADD_BENEFICIARY_ICON, Assets.SEND_ICON];

  @override
  BuildContext getContext() {
    return this.context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: 230,
            child: HomeTopBar(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
//                    getMyAccountsWidget(),
                    getTransferToWidget(),
                    getPaymentWidget(),
//                    getTransactionsWidget()
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
      height: 80,
      margin: EdgeInsets.only(left: 16, top: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "My Accounts",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                Strings.SEE_ALL,
                textAlign: TextAlign.center,
                style: BaseStyles.seeAllTextStyle,
              )
            ],
          ),
          Container(
            height: 50,
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
      return Align(
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
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Wallet",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 18, 52, 86),
                        fontFamily: "",
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
      );
    }
    else{
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 141,
          height: 40,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(Borders.secondaryBorder),
            borderRadius: Radii.k8pxRadius,
          ),
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
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 12),
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
      );
    }
  }

  getTransferToWidget()
  {
    return Container(
        height: 140,
        margin: EdgeInsets.only(left: 16, top: 24, right: 16),
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
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
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
        height: 130,
        margin: EdgeInsets.only(left: 16, top: 24, right: 16),
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
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
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
        margin: EdgeInsets.only(left: 16, top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 30,
                  margin: EdgeInsets.only(top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Transactions",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  Strings.SEE_ALL,
                  textAlign: TextAlign.center,
                  style: BaseStyles.seeAllTextStyle,
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics:NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return getTransactionsItemWidget();
                  }),
            )
          ],
        )
    );
  }

  getTransactionsItemWidget()
  {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 13),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Row(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.accentElement,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 33,
                  height: 33,
                  margin: EdgeInsets.only(right: 16),
                  child: Image.asset(
                    Assets.PERSON_ICON,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "TODAY • 12:33",
                    textAlign: TextAlign.left,
                    style: BaseStyles.transactionItemDateTextStyle,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      "Andi Ruhiyat",
                      textAlign: TextAlign.left,
                      style: BaseStyles.transactionItemPersonNameTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "- Rp 300.000",
                textAlign: TextAlign.right,
                style: BaseStyles.transactionItemMoneyTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}