import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/my_account/enter_card_details_controller.dart';
import 'package:tara_app/screens/consumer/my_account/otp_verification_screen.dart';


class EnterCardDetails extends StatefulWidget {
  final String bic;
  EnterCardDetails(this.bic);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EnterCardDetailsState();
  }
}

class _EnterCardDetailsState extends BaseState<EnterCardDetails> {
  EnterCardDetailsController controller = EnterCardDetailsController();
  TransactionController progressController = Get.find();

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: pop,),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.connect_new_account),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(title: getTranslation(Strings.connect_new_account),addNewWidgetShow: false,),
      //_buildAppBar(context),
      body: Obx(() =>SafeArea(child: getRootContainer()).withProgressIndicator(showIndicator: progressController.showProgress.value)),
    );
  }

  Widget getRootContainer() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8),
              child:
              TextWithBottomOverlay(titleStr: getTranslation(Strings.enter_card_details)),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: textFormFieldContainer(
                  getTranslation(Strings.card_number),
                  Strings.card_number_ex,
                  TextInputType.number,
                  controller.txtCtrlBankAcc,false),
            ),
            Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                      getTranslation(Strings.expired_date),
                                      style: BaseStyles
                                          .textFormFieldHeaderTitleTextStyle,
                                      textAlign: TextAlign.left),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: textFormFieldContainer(
                                              "",
                                              Strings.mm,
                                              TextInputType.number,
                                              controller.txtCtrlExpMonth,false),
                                        )),
                                    Container(
                                      margin:
                                      EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "/",
                                        style: TextStyle(
                                          color: AppColors.light_grey_blue,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: textFormFieldContainer(
                                              "",
                                              Strings.yy,
                                              TextInputType.number,
                                              controller.txtCtrlExpYear,false),
                                        )),
                                  ],
                                ),
                              ]),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(getTranslation(Strings.cvv),
                                      style: BaseStyles
                                          .textFormFieldHeaderTitleTextStyle,
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  child: textFormFieldContainer(
                                      "",
                                      Strings.cvv,
                                      TextInputType.number,
                                      controller.txtCtrlCvv,true),
                                ),
                              ]),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: textFormFieldContainer(
                  getTranslation(Strings.name_on_card),
                  Strings.name_on_card,
                  TextInputType.text,
                  controller.txtCtrlNameOnCard,false),
            ),
          ]),
          getConfirmWidget()
        ],
      ),
    );
  }
  Widget getConfirmWidget() {
    return Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 32, top: 8, left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
           // color: AppColors.bottom_border_color),
            color: controller.btnColor.value),
        alignment: Alignment.center,
        child:Container(
              height: 48,
              alignment: Alignment.center,
              child: Text(
                getTranslation(Strings.CONTINUE),
                textAlign: TextAlign.center,
               // style: BaseStyles.cannotFindTextStyle,
                style: controller.textStyle.value,
              ),
            ).onTap(onPressed: (){
              print(controller.isCompleteValidate.value);
              if(controller.isCompleteValidate.value){
                controller.addNewCard(widget.bic,
                                          getLast6Numbers(controller.txtCtrlBankAcc.text),
                    controller.txtCtrlNameOnCard.text,
                    controller.txtCtrlBankAcc.text,
                    controller.txtCtrlCvv.text,
                    controller.txtCtrlExpMonth.text,
                    controller.txtCtrlExpYear.text,
                    "333333333333333",

                );
              }
            })

    );
  }

  Widget textFormFieldContainer(String headerTitle, String hint,
      TextInputType inputType, TextEditingController textEditingController,bool isObscure) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.light_grey_blue,
              width: 1.0,
            ),
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4, bottom: 4),
                child: Text(headerTitle,
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFieldWidget(
                        placeHolderStyle: BaseStyles.placeholderStyle,
                        hint: getTranslation(hint),
                        inputType: inputType,
                        isObscure: isObscure,
                        textController: textEditingController,
                        isIcon: false,
                        onChanged: (val) {
                          controller.validateCardDetails(hint,val.toString());
                          if(controller.isCompleteValidate.value){
                            controller.showIfTrue();
                          }else{
                            controller.showIfFalse();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }




  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

 String getLast6Numbers(String cardNumber) {
    return cardNumber.substring(cardNumber.length - 6);
 }



}
