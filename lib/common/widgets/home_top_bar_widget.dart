import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/rounded_button.dart';
import 'package:tara_app/screens/Merchant/cash_deposit.dart';
import 'package:tara_app/screens/Merchant/cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';

class HomeTopBar extends StatefulWidget {

  HomeTopBar({Key key, this.appName = ""}) : super(key: key);
  String appName;

  @override
  _HomeTopBarState createState() => _HomeTopBarState();
}

class _HomeTopBarState extends BaseState<HomeTopBar> {

  @override
  BuildContext getContext() {
    return this.context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                gradient: Gradients.primaryGradient,
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(16.0),
                    bottomRight: const Radius.circular(16.0),
                  )
              ),
              child: Container(),
            ),
          ),
          Positioned(
            left: 0,
            top: 35,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                      flex: 4.toInt(), child:Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                            width: 62,
                            height: 24,
                            margin: EdgeInsets.only(left: 16,top: 8),
                            child: Image.asset(
                              "assets/images/combined-shape-5.png",
                              fit: BoxFit.none,
                            ),
                          ),
                            Text(
                                widget.appName,
                                style: const TextStyle(
                                    color:  AppColors.fareColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PlayfairDisplay",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 12.0
                                )
                            )
                          ],
                        ),
                      )),
                      Expanded(
                        flex: 6.toInt(),
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 130,
                                height: 38,
                                margin: EdgeInsets.only(top: 9,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Hello",
                                        textAlign: TextAlign.right,
                                        style: BaseStyles.navigationTextStyle,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Kiran Kumar Yasala",
                                        textAlign: TextAlign.right,
                                        style: BaseStyles.nameTextStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 29,
                                    height: 29,
                                    margin: EdgeInsets.only(right: 4),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Positioned(
                                          right: 4,
                                          child: Image.asset(
                                            Assets.NOTIFICATION_ICON,
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 249, 80, 116),
                                              borderRadius: BorderRadius.all(Radius.circular(7)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                                  child: Text(
                                                    "3",
                                                    textAlign: TextAlign.center,
                                                    style: BaseStyles.notificationBadgeTextStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 33,
                                      height: 33,
//                                    margin: EdgeInsets.only(right: 16),
                                      child: Image.asset(
                                        Assets.PERSON_ICON,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                getSearchWidget(),
                Container(height: 8,),
                getTopOptions()
              ],
            ),
          ),
        ],
      ),
    );
  }

  getTopOptions()
  {
    if(widget.appName == "Merchant"){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(buttonText: Strings.SEND,image: Assets.SEND_ICON,),
            RoundedButton(buttonText: Strings.RECEIVE,image: Assets.RECEIVE_ICON,),
            RoundedButton(buttonText: "Cash Deposit",image: Assets.ic_cash_deposit,onPressed:(){
              return cashDepositBottomSheet();
            }),
            RoundedButton(buttonText: "Restock",image: Assets.ic_restock,),
          ],
        ),
      );
    }else if(widget.appName == "Agent"){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(buttonText: Strings.SEND,image: Assets.SEND_ICON,),
            RoundedButton(buttonText: Strings.RECEIVE,image: Assets.RECEIVE_ICON,),
            RoundedButton(buttonText: "Payment",image: Assets.ic_payment,),
            RoundedButton(buttonText: "CMS Top-Up",image: Assets.ic_topup,),
          ],
        ),
      );
    }else{
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(buttonText: Strings.SEND,image: Assets.SEND_ICON,),
            RoundedButton(buttonText: Strings.RECEIVE,image: Assets.RECEIVE_ICON,),
            RoundedButton(buttonText: Strings.ADD_BENEFICIARY,image: Assets.ADD_BENEFICIARY_ICON),
            RoundedButton(buttonText: Strings.SHOP,image: Assets.SHOP_ICON),
          ],
        ),
      );
    }

  }

  getSearchWidget() {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 40,
        margin: EdgeInsets.only(left: 16, top: 16, right: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(179, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(26, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(left: 8),
              child: getTabImage(Assets.SEARCH_ICON),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                "Try typing action, contact or merchant...",
                textAlign: TextAlign.left,
                style: BaseStyles.searchBarTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  cashDepositBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.width > 230 ? 500 : null,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: CashDepositWidget());
        });
  }
}