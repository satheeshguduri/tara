import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/drop_down_list.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/transfer_contacts_selection_screen.dart';
import 'package:tara_app/screens/consumer/enter_mpin.dart';
import 'package:tara_app/screens/consumer/transaction_detail_screen.dart';
import 'package:tara_app/utils/locale/utils.dart';

class SendWidget extends StatefulWidget {

  final Function(String) sendMoneyConfirmed;
  SendWidget({Key key,this.sendMoneyConfirmed}) : super(key: key);

  @override
  _SendWidgetState createState() => _SendWidgetState();
}

class _SendWidgetState extends BaseState<SendWidget> {

  TextEditingController amountTextController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();
  TextEditingController bankNameTextController = TextEditingController();
  bool isToShowList = false;
  FocusNode amountFocusNode = new FocusNode();
  List<BankInfo> arrBankInfo = [];
  List<BankInfo> arrFilterBankInfo = [];
  List<String> arrBankNames = [
    "Bank BCA",
    "Bank BNI",
    "Bank BRI",
    "Bank BTN",
    "Bank Mandiri",
    "May Bank",
    "Permata Bank",
  ];
  List<String> arrBankIcons = [
    Assets.ic_bca,
    Assets.ic_bni,
    Assets.ic_bri,
    Assets.ic_btn,
    Assets.ic_mandiri,
    Assets.ic_maybank,
    Assets.ic_permata,
  ];
  var selectedBankFromList = BankInfo();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void initState() {
    super.initState();
    addListenersToRequiredTextField();
    loadData();
  }

  void loadData() {
    arrBankInfo = [];

    for (var i = 0; i < arrBankNames.length; i++) {
      var bank = BankInfo();
      bank.bankName = arrBankNames[i];
      bank.bankIcon = arrBankIcons[i];
      arrBankInfo.add(bank);
    }
  }

  void onChanged(TextEditingController textEditingController) {
    if (textEditingController==bankNameTextController)
    {
      var _searchText = textEditingController.text;
      if (_searchText != null &&
          _searchText.toString().trim().isNotEmpty &&
          _searchText.toString().trim().length > 2) {
        arrFilterBankInfo = [];
        if (arrBankInfo.isNotEmpty) {
          arrFilterBankInfo = arrBankInfo
              .where((bank) => bank.bankName
              .toLowerCase()
              .contains(_searchText.toLowerCase()))
              .toList();
          if (arrFilterBankInfo.isNotEmpty) {
            setState(() {
              isToShowList = true;
              selectedBankFromList = BankInfo();
            });
          }
        }
      } else {
        if (textEditingController.text == "") {
          setState(() {
            _searchText = "";
            textEditingController.text = "";
            arrFilterBankInfo.clear();
            isToShowList = false;
          });
        }
      }
    }
    else{
      setState(() {

      });
    }
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
                                child: TextWithBottomOverlay(titleStr: Strings.SEND,),
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
                          textFormFieldContainer(getTranslation(Strings.AMOUNT),getTranslation(Strings.enter_amount),TextInputType.number,amountTextController,null,amountFocusNode),
                          textFormFieldContainer(getTranslation(Strings.BANK_NAME),getTranslation(Strings.ENTER_BANK_NAME),TextInputType.text,bankNameTextController,selectedBankFromList,null),
                          (isToShowList==true && arrFilterBankInfo.isNotEmpty)?Container(
                            margin: EdgeInsets.only(top: 1,bottom: 3),
                            child: DropDownList(banksList: arrFilterBankInfo,onPressed: (selectedBank){
                              selectedBankFromList = selectedBank;
                              bankNameTextController.text = selectedBank.bankName;
                              setState(() {
                                isToShowList = false;
                                arrFilterBankInfo.clear();
                              });
                            },),
                          ):Container(),
                          isToShowList==false?textFormFieldContainer(getTranslation(Strings.message),getTranslation(Strings.enter_message),TextInputType.text,messageTextController,null,null):Container(),
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

  Widget _getConfirmWidget() {
    return InkWell(
      onTap: () {
        enterMPINBottomSheet();
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


  Future  enterMPINBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return EnterMPIN( isFromSendMoney:true,sendMoneyConfirmed: (){
            widget.sendMoneyConfirmed(amountTextController.text.toString());
            Navigator.pop(context);
          },);
        });
  }

  void addListenersToRequiredTextField() {
    amountFocusNode.addListener(() {
      bool hasFocus = amountFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  Widget textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController,BankInfo bankInfo,FocusNode focusNode)
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
                      flex: (bankInfo!=null&&bankInfo.bankIcon!=null&&bankInfo.bankIcon!=""
                          &&textEditingController != amountTextController
                          &&textEditingController != messageTextController)?2.5.toInt():0,
                      child:(bankInfo!=null&&bankInfo.bankIcon!=null&&bankInfo.bankIcon!=""
                          &&textEditingController != amountTextController
                          &&textEditingController != messageTextController)?Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          bankInfo.bankIcon,
                          fit: BoxFit.none,
                          width: 50,
                          height: 24,
                        ),
                      ):Container(),
                    ),
                    Expanded(
                      flex: (bankInfo!=null&&bankInfo.bankIcon!=null&&bankInfo.bankIcon!=""
                          &&textEditingController != amountTextController
                          &&textEditingController != messageTextController)?7.5.toInt():1,
                      child:TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){
                        onChanged(textEditingController);
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