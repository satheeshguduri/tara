import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/add_new_bank_account.dart';
import 'package:tara_app/screens/consumer/bank_transfer_accounts_list.dart';
import 'package:tara_app/screens/consumer/enter_mpin.dart';
import 'package:tara_app/screens/consumer/transaction_detail.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_widget_controller.dart';
import 'package:tara_app/screens/merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../../injector.dart';
import 'my_account/otp_verification_screen.dart';

class TransferDetailsEntryScreen extends StatefulWidget {

  // final String title;
  // final BankAccountContactInfo bankAccInfo;
  // final Contact taraContact;
  // final bool selfTransfer;
  //
  // TransferDetailsEntryScreen({Key key, this.title,
  //   this.bankAccInfo,this.taraContact, this.selfTransfer = false}) : super(key: key);

  final Contact taraContact;
  final BeneDetailBean beneContact;

  TransferDetailsEntryScreen({Key key,this.taraContact,this.beneContact}) : super(key: key);



  @override
  TransferDetailsEntryScreenState createState() => TransferDetailsEntryScreenState();
}

class TransferDetailsEntryScreenState extends BaseState<TransferDetailsEntryScreen> {
  TextEditingController txtCtrlBankName = TextEditingController();
  TextEditingController txtCtrlBankAcc = TextEditingController();
  TextEditingController txtCtrlTransType = TextEditingController();
  TextEditingController txtCtrlAccHolderName = TextEditingController();
  TransferDetailsEntryWidgetController uiController = TransferDetailsEntryWidgetController();
  TransactionController transactionController = Get.find();
  String bic;
  num accountTokenId;
  var formKey = GlobalKey<FormState>();


  //List<PaymentSource> arrPaymentSource = List<PaymentSource>();
  // List<String> bankList = ["Bank BCA", "BANK BRI", "BANK Mandiri", "Maybank"];
  // List<String> imgList = [
  //   Assets.ic_bank1,
  //   Assets.ic_bank2,
  //   Assets.ic_bank3,
  //   Assets.ic_bank4
  // ];
  List<String> transTypeList = ["Others", "Others1", "Others2"];
  List<String> arrFrequency = [Strings.DAILY, Strings.MONTHLY, Strings.YEARLY];

  final TextEditingController _typeAheadController = TextEditingController();

  // TransactionController controller = Get.find<TransactionController>();
 // TransactionController controller = Get.find();


  String frequencyType;
  String transType;
  PaymentSource source;
  PaymentSource bankAccount;

  BankModel selectedbank;
  bool isToSaveContact = false;
  bool isBankAccVerFailed = false;
  BankAccountContactInfo contactInfo;

  // Contact taraContact;

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  //@override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   contactInfo = widget.bankAccInfo;
  //   taraContact = widget.taraContact;
  //
  //   BankList.init();
  //   for (var i = 0; i < bankList.length; i++) {
  //     var paymentSource = PaymentSource();
  //     paymentSource.bankName = bankList[i];
  //     paymentSource.image = imgList[i];
  //     arrPaymentSource.add(paymentSource);
  //   }
  //
  //   // default values for drop downs
  //   frequencyType = arrFrequency.first;
  //   source = arrPaymentSource.first;
  //
  //
  // }

  @override
  void initState() {
    super.initState();
    uiController.getCustomerProfile2();
  }

  getRecepient() {
    // if(taraContact != null){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getTranslation(Strings.RECIPIENT),
              style: const TextStyle(
                  color: AppColors.fareColor,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0)),
          Row(
            children: [
              Image.asset(
                "assets/images/avatar-11.png",
                height: 32,
                width: 32,
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          checkContactInfo(),
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                      Image.asset(
                        Assets.tara_contacts,
                        height: 32,
                        width: 32,
                      )
                    ],),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        phoneNumberValidation(widget.taraContact),
                        textAlign: TextAlign.left,
                        style: BaseStyles.transactionItemDateTextStyle,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ]);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() =>
        SafeArea(
            child: getRootContainer().withProgressIndicator(
                showIndicator: transactionController.showProgress.value)));
  }




  _getDropDownVal(String type) {
    if (type == "transactionType") {
      return transType;
    } else if (type == "paymentSource") {
      return source;
    } else if (type == "frequency") {
      return frequencyType;
    } else if (type == "bankAccount") {
      return bankAccount;
    }
  }

  _getDropDownHint(String type) {
    if (type == "transactionType") {
      return Text(getTranslation(Strings.TRANSACTION_TYPE_HINT));
    } else if (type == "paymentSource") {
      return Container();
    } else if (type == "frequency") {
      return Text(getTranslation(Strings.TRANSACTION_TYPE_HINT));
    } else if (type == "bankAccount") {
      return Text(getTranslation(Strings.SELECT_ACC));
    }
  }

  _getDropdownItems(String type) {
    if (type == "transactionType") {
      return transTypeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          child: (Text(value)),
          value: value,
        );
      }).toList();
    } else if (type == "paymentSource" || type == "bankAccount") {
      return (uiController.mappedItems.value).map((
          MappedBankAccountsBean item) {
        return DropdownMenuItem<String>(
          child: getCustomItemWidget(item.bankName, item.maskedAccountNumber),
          //Text(item.bankName),
          onTap: () {
            bic = item.bic;
            accountTokenId = item.accountTokenId;
          },
        );
      }
      ).toList();
    } else if (type == "frequency") {
      return arrFrequency.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          child: (Text(value)),
          value: value,
        );
      }).toList();
    }
  }

  _getDropDownList(String type) {
    return DropdownButton(
      icon: Container(
        margin: EdgeInsets.only(right: type == "paymentSource" ? 16 : 0),
        child: Image.asset(Assets.ic_dropdown),
      ),
      value: _getDropDownVal(type),
      hint: _getDropDownHint(type),
      isExpanded: true,
      itemHeight: 60,
      underline: Container(
          margin:
          EdgeInsets.only(top: 32, right: type == "paymentSource" ? 16 : 0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          )),
      onChanged: (val) {
        setState(() {
          if (type == "transactionType") {
            transType = val;
          } else if (type == "frequency") {
            frequencyType = val;
          } else if (type == "bankAccount") {
            bankAccount = val;
          } else {
            source = val;
          }
        });
      },
      items: _getDropdownItems(type),
    );
  }

  _getContinueWidget() {
    return Container(
      height: 48,
      margin: EdgeInsets.only(bottom: 16, top: 24, left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: AppColors.bottom_border_color),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.CONTINUE),
        textAlign: TextAlign.center,
        style: BaseStyles.addNewBankAccount,
      ),
    ).onTap(onPressed: () {
      if(formKey.currentState.validate()){

      // print("amount"+ uiController.txtCtrlTransferAmt.text);
        // print("message"+uiController.messageController.text);
        // print("bic"+bic.toString());
        // print("cvv"+uiController.cvvController.text);
        // print("accountTokenId"+accountTokenId.toString());
        // print("beneId"+widget.beneContact.beneId.toString());

        uiController.confirmToPay(
            mobile: widget.taraContact!=null?phoneNumberValidation(widget.taraContact,null):phoneNumberValidation(null,widget.beneContact),
            amount: uiController.amountController.text,
            remarks: uiController.messageController.text,
            bic: bic,
            cvv: uiController.cvvController.text,
            accountTokenId: accountTokenId,
            beneId: getBenId(widget.beneContact)
        );
      }
    });
  }

  getFrequencyStartTitle() {
    if (frequencyType == Strings.DAILY) {
      return getTranslation(Strings.START_DATE);
    } else if (frequencyType == Strings.MONTHLY) {
      return getTranslation(Strings.START_MONTH);
    } else if (frequencyType == Strings.YEARLY) {
      return getTranslation(Strings.START_YEAR);
    } else {
      return "";
    }
  }

  getFrequencyEndTitle() {
    if (frequencyType == Strings.DAILY) {
      return getTranslation(Strings.END_DATE);
    } else if (frequencyType == Strings.MONTHLY) {
      return getTranslation(Strings.END_MONTH);
    } else if (frequencyType == Strings.YEARLY) {
      return getTranslation(Strings.END_YEAR);
    } else {
      return "";
    }
  }

  _getStartEndWidget(bool isStart) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(isStart ? getFrequencyStartTitle() : getFrequencyEndTitle(),
              style: BaseStyles.textFormFieldHeaderTitleTextStyle,
              textAlign: TextAlign.left),
          Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: InkWell(
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isStart
                            ? getFrequencyStartTitle()
                            : getFrequencyEndTitle(),
                        style: BaseStyles.amountTextStyle,
                      ),
                      Image.asset(Assets.ic_dropdown)
                    ],
                  ),
                ),
                onTap: () {
                  // show date picker
                  if (isStart) {
                    // set time according to picker type secton
                  }
                },
              ))
        ]));
  }

  _createFrequencyWidget() {
    return Row(
      children: [
        Expanded(
          child: _getStartEndWidget(true),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(child: _getStartEndWidget(false)),
      ],
    );
  }

  _getRecurringWidget() {
    return (Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslation(Strings.FREQUENCY),
                        style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                        textAlign: TextAlign.left),
                    _getDropDownList("frequency")
                  ])),
          _createFrequencyWidget()
        ],
      ),
    ));
  }




  Widget getRootContainer() {
    return Scaffold(
      appBar: CustomAppBarWidget(
          title: getTranslation(Strings.transfer), addNewWidgetShow: false),
      body: SafeArea(
          child: Container(
            color: AppColors.background_color,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getRecipientWidget(),
                  Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffe9ecef),
                              offset: Offset(0, 1),
                              blurRadius: 0,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              transferDetailsHeadingWidget(),
                              // transferAmountWidget(),
                              getAmountWidget(),
                              getTheDivider(),

                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getTransactionTypeWidget(),
                                    getTheDivider(),
                                   // _getDropDownList("transactionType"),
                                  ]),
                              // textFormFieldContainer(
                              //     getTranslation(Strings.MESSAGE_OPT),
                              //     getTranslation(Strings.MESSAGE_OPT_HINT),
                              //     TextInputType.text,
                              //     txtCtrlTransType),
                              getMessageWidget(),
                              getTheDivider(),

                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    decoration: BoxDecoration(
                                        color: AppColors.pale_turquoise,
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                        borderRadius: Radii.border(5)),
                                    width: 24,
                                    height: 24,
                                    child: Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: Colors
                                            .transparent,
                                      ),
                                      child: Checkbox(
                                        activeColor: Colors.transparent,
                                        checkColor: AppColors
                                            .header_top_bar_color,
                                        value: isToSaveContact,
                                        tristate: false,
                                        onChanged: (bool isChecked) {
                                          setState(() {
                                            isToSaveContact = isChecked;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                    EdgeInsets.only(
                                        left: 16, right: 16, top: 16),
                                    child: Text(
                                        getTranslation(Strings.SET_RECURRING),
                                        style: BaseStyles
                                            .textFormFieldHeaderTitleTextStyle,
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                              isToSaveContact
                                  ? _getRecurringWidget()
                                  : Container()
                            ]),
                      )),
                  Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffe9ecef),
                              offset: Offset(0, 1),
                              blurRadius: 0,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             paymentSourceTitleWidget(),
                             getPaymentSourceWidget(),
                             getTheDivider(),
                            getCVVWidget(),
                            getTheDivider(),
                           // _getDropDownList("paymentSource")

                          ])),
                  _getContinueWidget()
                ],
              ),
            ),
          )),
    );
  }

  String phoneNumberValidation([Contact contactInfo,BeneDetailBean beneContactInfo]) {

    try {
      return contactInfo!=null?contactInfo.phones.elementAt(0).value:beneContactInfo.beneMobile;
    } catch (Exception) {
      return " ";
    }
  }

  String contactNameValidation(String displayName) {
    if (displayName != null)
      return displayName;
    return "";
  }


  Widget getCustomItemWidget(String bankname, String maskedAccountNumber) {
    return Row(
      children: [
        Container(margin: EdgeInsets.only(right: 8),
            child: Image.asset(Assets.ic_bca,)),
        Text(bankname + " - " +
            uiController.getAccountNumberOnly(maskedAccountNumber),
            style: TextStyles.inputFieldOn222
        )
      ],
    );
  }

  Widget transferDetailsHeadingWidget() {
    return Text(getTranslation(Strings.TRANSFER_DETAILS),
        style: TextStyles.transferDetailsHeadingTextStyle
    );
  }

  Widget getRecipientWidget() {
    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          boxShadow: [
            BoxShadow(
                color: Color(0xffe9ecef),
                offset: Offset(0, 1),
                blurRadius: 0,
                spreadRadius: 0)
          ],
        ),
        child: getRecepient()
    );
  }


  Widget getAmountWidget() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextWidget(getTranslation(Strings.TRANSFER_AMT)),
          amountTextField()
        ],

      ),
    );
  }

  Divider getTheDivider() {
    return Divider(
      color: Colors.grey,
      height: 1,
      thickness: 1,
    );
  }

  Widget amountTextField() {
    return Container(
      height: 48,
      child: TextFormField(
        controller: uiController.txtCtrlTransferAmt,
        decoration: removeUnderlineAndShowHint(
            getTranslation(Strings.entertheamount)),
        keyboardType: TextInputType.number,
        style: TextStyles.inputFieldOn222,
        validator: (value) {
          return getTranslation(uiController.validateAmountWidget(value));
        },
      ),
    );
  }

  InputDecoration removeUnderlineAndShowHint(String hint) {
    return InputDecoration(border: InputBorder.none, hintText: hint);
  }

  Widget getTransactionTypeWidget() {
    return Container(
        margin: EdgeInsets.only(
            top: 16, bottom: 4),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonTextWidget(getTranslation(Strings.TRANSACTION_TYPE)),
              getTransactionDropDownList(),
            ]
        )

    );
  }

  Widget getTransactionDropDownList() {
    return Container(
      height: 48,
      child: DropdownButtonFormField(
        decoration: removeUnderlineAndShowHint(""),
        icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,
            width: 24.0,
            height: 24.0),
        style: TextStyles.inputFieldOn222,
        value: uiController.currentSelectedCategory.value,
        isExpanded: true,

        onChanged: (String selectedCategory) {
          // controller.currentSelectedCategory.value = selectedCategory;
        },

        items: <String>['Gift', 'Credit', 'Shopping']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),

      ),
    );
  }

  Widget commonTextWidget(String text) {
    return Text(
        text,
        style: BaseStyles.textFormFieldHeaderTitleTextStyle
    );
  }

  Widget getMessageWidget() {
    return  Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commonTextWidget(getTranslation(Strings.message)),messageTextField()],
      ),
    );


  }

  Widget messageTextField() {
    return  Container(
      height: 62,
     // margin: EdgeInsets.only(bottom: 11),
      child: TextFormField(
        controller: uiController.messageController,
        decoration:  removeUnderlineAndShowHint(getTranslation(Strings.typeyourmessage)),
        keyboardType: TextInputType.text,
        maxLines: 2,
        style: TextStyles.inputFieldOn222,
        validator: (value) {
          return getTranslation(uiController.validateMessageWidget(value));
        },
      ),
    );
  }

 Widget paymentSourceTitleWidget() {
   return Text(getTranslation(Strings.PAYMENT_SOURCE),
        style:TextStyles.transferDetailsHeadingTextStyle);
  }

  Widget getPaymentSourceWidget() {
    return
      //Obx(()=>
      Container(
        height: 48,
        child: DropdownButtonFormField(
            decoration: removeUnderlineAndShowHint(""),
            icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),
            style: TextStyles.inputFieldOn222,
            isExpanded: true,
            items:// controller.customerProfile.value?.mappedBankAccounts??[]{
            (uiController.mappedItems.value)?.map((MappedBankAccountsBean item) {
              bic = item.bic;
              accountTokenId = item.accountTokenId;
              return DropdownMenuItem<String>(
                child: getCustomItemWidget(item.bankName,item.maskedAccountNumber),
                onTap: (){
                  bic = item.bic;
                  accountTokenId = item.accountTokenId;
                },
              );
            })?.toList()??[],
            onChanged: (val){
            }

        ),
      );
    // );
  }


  Widget getCVVWidget() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextWidget(getTranslation(Strings.cvv)),
          cvvTextField()
        ],

      ),
    );
  }

  Widget cvvTextField() {
    return  Container(
      height: 48,
      child: TextFormField(
        decoration:  removeUnderlineAndShowHint(getTranslation(Strings.enterthecvv)),
        style: TextStyles.inputFieldOn222,
        obscureText: true,
        obscuringCharacter: "*",
        controller: uiController.cvvController,
        keyboardType: TextInputType.number,
        validator: (value) {
          return getTranslation(uiController.validateCvvWidget(value));
        },
      ),
    );
  }

  String checkContactInfo() {
    if(widget.taraContact!=null)
     return contactNameValidation(widget.taraContact.displayName);
    else{
      return contactNameValidation(widget.beneContact.beneName);

    }

  }

 num getBenId(BeneDetailBean beneContact) {
   return  beneContact!=null? beneContact.beneId:null;
 }
}

  class PaymentSource {
  String image;
  String bankName;
  }

