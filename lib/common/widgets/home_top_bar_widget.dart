import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/rounded_button.dart';
import 'package:tara_app/screens/base/base_state.dart';

class HomeTopBar extends StatefulWidget {
  HomeTopBar({Key key}) : super(key: key);

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
      height: 230,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 160,
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
            top: 0,
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
                      flex: 3.2.toInt(), child:Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 62,
                          height: 24,
                          margin: EdgeInsets.only(left: 16,top: 8),
                          child: Image.asset(
                            "assets/images/combined-shape-5.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      )),
                      Expanded(
                        flex: 6.8.toInt(),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              height: 38,
                              margin: EdgeInsets.only(top: 9, right: 8),
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
                                      "Kiran Kumar",
                                      textAlign: TextAlign.right,
                                      style: BaseStyles.nameTextStyle,
                                      maxLines: 1,
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
                                    margin: EdgeInsets.only(right: 16),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundedButton(buttonText: Strings.SEND,image: Assets.SEND_ICON,),
          RoundedButton(buttonText: Strings.RECEIVE,image: Assets.RECEIVE_ICON,),
          RoundedButton(buttonText: Strings.ADD_BENEFICIARY,image: Assets.ADD_BENEFICIARY_ICON,),
          RoundedButton(buttonText: Strings.SHOP,image: Assets.SHOP_ICON,),
        ],
      ),
    );
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

}