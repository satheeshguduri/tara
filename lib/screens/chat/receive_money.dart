import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/to_address_response.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/utils/locale/utils.dart';

class ReceiveWidget extends StatefulWidget {

  final Function(String) receiveMoneyConfirmed;
  final CustomerProfile customerProfile;
  ReceiveWidget({Key key,this.receiveMoneyConfirmed,this.customerProfile}) : super(key: key);

  @override
  _ReceiveWidgetState createState() => _ReceiveWidgetState();
}

class _ReceiveWidgetState extends BaseState<ReceiveWidget> {

  TextEditingController amountTextController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();

  FocusNode amountFocusNode = new FocusNode();

  @override
  BuildContext getContext() {
    return context;
  }

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
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: TextWithBottomOverlay(titleStr: Strings.RECEIVE,),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context, false);
                              },
                              child:Align(
                                alignment: Alignment.topRight,
                                child:  Container(
                                    width: 32,
                                    height: 24,
                                    margin: EdgeInsets.only(bottom: 24,right: 8),
                                    child: IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: (){
                                        Navigator.pop(context, false);
                                      },
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      textFormFieldContainer(getTranslation(Strings.AMOUNT),getTranslation(Strings.enter_amount),TextInputType.number,amountTextController,amountFocusNode),
                      textFormFieldContainer(getTranslation(Strings.message),getTranslation(Strings.enter_message),TextInputType.text,messageTextController,null),
                      _getConfirmWidget()
                    ],
                  ),
                ),
              ),
            )
        )
    )
    );
  }

  _getConfirmWidget() {
    return InkWell(
      onTap: () async{
        await Get.find<TransactionController>().paymentInitiation(requestType: RequestType.COLLECT,trContext:TransactionContext.PAYMENT_REQUEST,amount:double.parse(amountTextController.text),toAddress: ToAddressResponse(mobileNumber: widget.customerProfile.mobileNumber,customerProfile: widget.customerProfile));
        widget.receiveMoneyConfirmed(amountTextController.text.toString());
        Navigator.pop(context);
      },
      child:  Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 36,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: (amountTextController.text.toString().isNotEmpty&&messageTextController.text.toString().isNotEmpty)?Color(0xffb2f7e2):Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.confirm),
          textAlign: TextAlign.center,
          style: (amountTextController.text.toString().isNotEmpty&&messageTextController.text.toString().isNotEmpty)?BaseStyles.chatItemDepositSuccessMoneyTextStyle:BaseStyles.verifyTextStyle,
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    addListenersToRequiredTextField();
  }

  addListenersToRequiredTextField() {
    amountFocusNode.addListener(() {
      bool hasFocus = amountFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController,FocusNode focusNode)
  {
    return Container(
        margin: EdgeInsets.only(top:8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide( //                   <--- left side
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4,bottom: 4),
                child: Text(
                    headerTitle,
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){
                        setState(() {

                        });
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}