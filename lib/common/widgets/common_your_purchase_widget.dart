import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';


class CommonPurchaseWidget extends StatefulWidget {
  const CommonPurchaseWidget({ Key key,}) : super(key: key);

  @override
  CommonPurchaseWidgetState createState() => CommonPurchaseWidgetState();
}

class CommonPurchaseWidgetState extends BaseState<CommonPurchaseWidget> {

  double parentHeight = 520;
  double childHeight = 96;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.90,
                    child: Container(
                      padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x1f000000),
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: 0),
                            BoxShadow(
                                color: const Color(0x14000000),
                                offset: Offset(0, 0),
                                blurRadius: 2,
                                spreadRadius: 0)
                          ],
                          color: AppColors.primaryBackground),
                      child:  Wrap(
                        children: <Widget>[

                          Row(
                            children: [
                              Expanded(child: TextWithBottomOverlay(titleStr: Strings.yourpurchase)),
                              Container(
                                  child: getSvgImage(imagePath: Assets.close_icon).onTap(onPressed: ()=> pop())
                              ),
                            ],
                          ),
                          getDivider(color: Colors.grey[200]),
                          getProductDetailWidget(),
                          Container(
                            child: Column(
                                children: [
                                  billDetailsText(),
                                  priceThreeRows(Strings.price,"255"),
                                  priceThreeRows(Strings.adminfee,"9665"),
                                  priceThreeRows(Strings.servicefee,"1234"),
                                  dividerRow(),
                                  totalRow()

                                ]),
                          ),
                          getContinueWidget()
                        ],
                      ),
                    ),
                  ),
                )
            )
        )
    );
  }

  Container getProductDetailWidget() {
    return Container(
                          decoration: BoxDecoration(
                              color: AppColors.secondaryBackground,
                              borderRadius: Radii.k8pxRadius
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              priceThreeRows(Strings.price,"255"),
                              priceThreeRows(Strings.price,"255"),
                              priceThreeRows(Strings.price,"255"),
                            ],

                          ),
                        );
  }



  Widget getYourPurchaseWidget()
  {
    return Center(
      child: Container(
          height: parentHeight,
          child:Stack(
            children: [
                Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x1f000000),
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: 0),
                          BoxShadow(
                              color: const Color(0x14000000),
                              offset: Offset(0, 0),
                              blurRadius: 2,
                              spreadRadius: 0)
                        ],
                        color: AppColors.primaryBackground),
                    child: Wrap(
                      children: <Widget>[

                       Row(
                         children: [
                            Expanded(child: TextWithBottomOverlay(titleStr: Strings.yourpurchase)),
                            Container(
                              child: getSvgImage(imagePath: Assets.close_icon).onTap(onPressed: ()=> pop())
                            ),
                         ],
                        ),
                        Container(
                          color: Colors.grey[200],
                          height: 1,
                        ),
                        Container(
                          height: childHeight,
                          color: Colors.blue,
                        ),
                        Container(
                              child: Column(
                              children: [
                                billDetailsText(),
                                priceThreeRows(Strings.price,"255"),
                                priceThreeRows(Strings.adminfee,"9665"),
                                priceThreeRows(Strings.servicefee,"1234"),
                                dividerRow(),
                                totalRow()

                              ]),
                        ),
                         getContinueWidget()
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }






  Widget getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16,top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.paynow),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: (){

    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }



  Widget dividerRow() {
   return Container(
      color: Colors.grey[200],
      height: 1,
    );
  }

 Widget  billDetailsText() {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(top: 16,bottom:16),
    child: Text(
          getTranslation(Strings.bill_details),
          style: TextStyles.subtitle1222
      ),
  );
  }

 Widget priceThreeRows(String detail,String value) {

   return Container(
     margin: EdgeInsets.only(top: 8,bottom: 8),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [

         Text(
             getTranslation(detail),
             style:TextStyles.yourPurchaseBillsDetailsTextStyle
         ),
         Text(
              getTranslation(Strings.RP)+" "+value,
             style:TextStyles.yourPurchaseBillsDetailsTextStyle
         ),

       ],
     ),
   );

  }



 Widget totalRow() {
    return // Total


      Container(
        margin: EdgeInsets.only(top: 8,bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
                getTranslation(Strings.total),
                style:TextStyles.yourPurchaseBillsTotalTextStyle
            ),
            Text(
                getTranslation(Strings.RP)+" "+"4252",
                style:TextStyles.yourPurchaseBillsTotalTextStyle
            ),

          ],
        ),
      );

 }

}
