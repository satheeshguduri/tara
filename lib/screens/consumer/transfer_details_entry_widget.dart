import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/common/constants/values.dart';

import 'Transfer_Details_Entry_Widget_Controller.dart';


class TransferDetailsEntryWidget extends StatefulWidget {
  TransferDetailsEntryWidget({ Key key,}) : super(key: key);

  @override
  TransferDetailsEntryWidgetState createState() => TransferDetailsEntryWidgetState();
}

class TransferDetailsEntryWidgetState extends BaseState<TransferDetailsEntryWidget> {

  TransferDetailsEntryWidgetController controller = TransferDetailsEntryWidgetController();
  var formKey = GlobalKey<FormState>();
  String bic;
  num accountTokenId;


  @override
  Widget build(BuildContext context)  {
      return SafeArea(
          top: false,
          child: Container(
              margin: EdgeInsets.only(top: 30),
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
                    alignment: Alignment.topRight,
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
                                Expanded(child: TextWithBottomOverlay(titleStr: getTranslation(Strings.transfer))),
                                Container(
                                    child: getSvgImage(imagePath: Assets.close_icon).onTap(onPressed: ()=> pop())
                                ),
                              ],
                            ),
                            Container(
                              child: Form(
                                key: formKey,
                                child: Column(
                                    children: [
                                      getAmountWidget(),
                                     // getTheDivider(),
                                      serviceFeeWidget(),
                                      getMessageWidget(),
                                      getTheDivider(),
                                      categoryTransferWidget(),
                                      //getTheDivider(),
                                      paymentSourceWidget(),
                                     // getTheDivider(),
                                      cvvWidget(),
                                     // getTheDivider(),

                                    ]),
                              ),
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




  Widget getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16,top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.confirm),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: (){
      if(formKey.currentState.validate()){
        controller.confirmToPay(bic,accountTokenId);
      }
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

 Widget getAmountWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [commonTextWidget("Amount"),amountTextField()],

  );


 }
  Widget commonTextWidget(String text) {
    return Text(
        text,
        style: TextStyles.caption222WithHeight2
    );

  }

  Widget amountTextField() {
    return  TextFormField(
       controller: controller.amountController,
       keyboardType: TextInputType.number,
       validator: (value) {
         return controller.validateAmountWidget(value);
       },
     );
  }

 Widget serviceFeeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [// Service fee
          Text(
              "Service fee ",
              style:TextStyles.serviceFeeTextStyle
          )
          ,Text(
   "+ Rp 4.500",
   style: TextStyles.serviceFeeAmountTextStyle
          ),
        ],
      ),
    );

  }

 Widget getMessageWidget() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [commonTextWidget("Message"),messageTextField()],
    );


  }

 Widget messageTextField() {
    return  TextFormField(
      controller: controller.messageController,
      keyboardType: TextInputType.text,
      validator: (value) {
        return controller.validateMessageWidget(value);
      },
    );
  }

  categoryTransferWidget()  {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [commonTextWidget("Category Transfer"),
       // categoryTextField(),
        getCategoryDropDownList(),],
    );


  }

 Widget categoryTextField() {
    return  TextFormField(
      controller: controller.categoryController,
      keyboardType: TextInputType.number,
      validator: (value) {
        return controller.validateCategoryWidget(value);
      },
    );
  }

 Widget paymentSourceWidget() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [commonTextWidget("Payment Source"),
        //paymentSourceTextField(),
        getPaymentsDropDownList()
      ],
    );


  }

 Widget paymentSourceTextField() {
    return  TextFormField(
      controller: controller.paymentSourceController,
      // keyboardType: TextInputType.number,
      validator: (value) {
        return controller.validatePaymentSourceWidget(value);
      },
    );
  }

 Widget cvvWidget() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [commonTextWidget("CVV"),cvvTextField()],
    );


  }

 Widget cvvTextField() {
    return  TextFormField(
      controller: controller.cvvController,
      keyboardType: TextInputType.number,
      validator: (value) {
        return controller.validateCvveWidget(value);
      },
    );
  }

  Widget getPaymentsDropDownList() {
    return FutureBuilder(
      future: Get.find<TransactionController>().getCustomerProfile2(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          CustomerProfileDetailsResponse data = snapshot.data;
          return getDropdown(data.mappedBankAccounts);
        }
        return BaseWidgets.getIndicator;
      },
    );
  }

  Divider getTheDivider() {
    return Divider(
      color: AppColors.input_field_line_off_2_2_2,
      height: 1,
    );
  }

InputDecoration  getUnderLineBorder() {
  return  InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(
            //  color: AppColors.input_field_line_off_2_2_2,

              color: Colors.red
            )
        )
    );
  }

 Widget getCategoryDropDownList() {
   return DropdownButtonFormField(

     icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),

     // underline: Container(height: 1,color: AppColors.input_field_line_off_2_2_2),

     // value: _getDropDownVal(type),
     // hint: _getDropDownHint(type),

     isExpanded: true,
     itemHeight: 48,
     // underline: Container(
     //     //margin: EdgeInsets.only(top: 32, right: type == "paymentSource" ? 16 : 0),
     //     decoration: BoxDecoration(
     //       border: Border(
     //         bottom: BorderSide(
     //           color: Colors.grey,
     //           width: 1.0,
     //         ),
     //       ),
     //     )),
     onChanged: (val)
     {

     },
     items: <String>['Gift', 'Credit', 'Shopping']
         .map<DropdownMenuItem<String>>((String value) {
       return DropdownMenuItem<String>(
         value: value,
         child: Text(value),
       );
     }).toList(),
   );
 }

  Widget getDropdown(List<MappedBankAccountsBean> mappedBankAccounts) {
  return  DropdownButtonFormField(

      icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),
      isExpanded: true,
      items: mappedBankAccounts.map((MappedBankAccountsBean item) {
        return DropdownMenuItem<String>(
          child: Text(item.bankName),
          onTap: (){
            bic = item.bic;
            accountTokenId = item.accountTokenId;
          },
        );
      }).toList(),
    );
  }
}
