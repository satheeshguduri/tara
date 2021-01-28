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
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/add_new_bank_account.dart';
import 'package:tara_app/screens/consumer/bank_transfer_accounts_list.dart';
import 'package:tara_app/screens/consumer/enter_mpin.dart';
import 'package:tara_app/screens/consumer/transaction_detail.dart';
import 'package:tara_app/screens/merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../../injector.dart';
import 'my_account/otp_verification_screen.dart';

class BankTransferNewContact extends StatefulWidget {

  final String title;
  final BankAccountContactInfo bankAccInfo;
  final Contact taraContact;
  final bool selfTransfer;

  BankTransferNewContact({Key key, this.title,
    this.bankAccInfo,this.taraContact, this.selfTransfer = false}) : super(key: key);

  @override
  _BankTransferNewContactState createState() => _BankTransferNewContactState();
}

class _BankTransferNewContactState extends BaseState<BankTransferNewContact> {
  TextEditingController txtCtrlBankName = TextEditingController();
  TextEditingController txtCtrlBankAcc = TextEditingController();
  TextEditingController txtCtrlTransType = TextEditingController();
  TextEditingController txtCtrlAccHolderName = TextEditingController();

  List<PaymentSource> arrPaymentSource = List<PaymentSource>();
  List<String> bankList = ["Bank BCA", "BANK BRI", "BANK Mandiri", "Maybank"];
  List<String> imgList = [
    Assets.ic_bank1,
    Assets.ic_bank2,
    Assets.ic_bank3,
    Assets.ic_bank4
  ];
  List<String> transTypeList = ["Others", "Others1", "Others2"];
  List<String> arrFrequency = [Strings.DAILY, Strings.MONTHLY, Strings.YEARLY];

  final TextEditingController _typeAheadController = TextEditingController();
   TransactionController controller = Get.find();
  //TransactionController controller = TransactionController();


  String frequencyType;
  String transType;
  PaymentSource source;
  PaymentSource bankAccount;

  BankModel selectedbank;
  bool isToSaveContact = false;
  bool isBankAccVerFailed = false;
  BankAccountContactInfo contactInfo;

  Contact taraContact;

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactInfo = widget.bankAccInfo;
    taraContact = widget.taraContact;

    BankList.init();
    for (var i = 0; i < bankList.length; i++) {
      var paymentSource = PaymentSource();
      paymentSource.bankName = bankList[i];
      paymentSource.image = imgList[i];
      arrPaymentSource.add(paymentSource);
    }

    // default values for drop downs
    frequencyType = arrFrequency.first;
    source = arrPaymentSource.first;
  }

  getRecepient(){
    if(taraContact != null){
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
                            contactNameValidation(taraContact.displayName),
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
                          phoneNumberValidation(taraContact),
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
    }else if(contactInfo != null){
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
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          contactInfo.name,
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          contactInfo.accountNumber,
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemDateTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(getTranslation(Strings.SELECT_ACC),
                        style: BaseStyles
                            .textFormFieldHeaderTitleTextStyle,
                        textAlign: TextAlign.left),
                  ),
                  _getDropDownList("bankAccount"),
                ]),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: 16,bottom: 8),
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.light_grey_blue,
                        width: 1
                    ),
                    color: AppColors.primaryBackground,
                    borderRadius: Radii.border(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.ic_plus,
                      fit: BoxFit.none,
                    ),
                    Text(getTranslation(Strings.ADD_NEW_BANK_ACCOUNT),
                      style: const TextStyle(
                          color: AppColors.fareColor,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),

                    )
                  ],
                ),
              ),
              onTap: (){
                addNewBankAccountBottomSheet();
              },
            )
          ]);
    }else{
      return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslation(Strings.RECIPIENT),
                style: const TextStyle(
                    color: AppColors.fareColor,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0)),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(getTranslation(Strings.BANK_NAME),
                        style: BaseStyles
                            .textFormFieldHeaderTitleTextStyle,
                        textAlign: TextAlign.left),
                  ),
                  _getDropDownList("bankAccount"),
                ]),
            textFormFieldContainer(
                getTranslation(Strings.BANK_ACCOUNT_NUMBER),
                getTranslation(Strings.BANK_ACCOUNT_NUMBER),
                TextInputType.text,
                txtCtrlBankAcc),
            textFormFieldContainer(
                getTranslation(Strings.BANK_HOLDER_NAME),
                getTranslation(Strings.BANK_HOLDER_NAME),
                TextInputType.text,
                txtCtrlAccHolderName),
            Container(
              margin: EdgeInsets.only(top: 16,bottom: 16),
              child:Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (isToSaveContact) ? AppColors.header_top_bar_color : AppColors.uncheck_color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        )),
                    width: 24,
                    height: 24,
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.transparent,
                      ),
                      child: Checkbox(
                        activeColor: Colors.transparent,
                        checkColor: AppColors.header_top_bar_color,
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
                    margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                    child: Text(
                        getTranslation(Strings.SAVE_TO_MY_CONTACT),
                        style: BaseStyles.saveToMyContactTextStyle,
                        textAlign: TextAlign.left
                    ),),
                ],
              ) ,
            )



          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() => SafeArea(
        child: getRootContainer().withProgressIndicator(showIndicator: controller.showProgress.value)));
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      centerTitle: false,
      leading: IconButton(
        //icon:Icon(Icons.arrow_back),
          icon: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title: Text("Transfer",
          style: const TextStyle(
              color: AppColors.fareColor,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 18.0)),
    );
  }

  textFormFieldContainer(String headerTitle, String hint,
      TextInputType inputType, TextEditingController textEditingController) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
              textEditingController == txtCtrlBankAcc && isBankAccVerFailed
                  ? AppColors.badge_color
                  : Colors.grey,
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
                    style: textEditingController == txtCtrlBankAcc &&
                        isBankAccVerFailed
                        ? BaseStyles.error_text_style
                        : BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFieldWidget(
                        hint: hint,
                        inputType: inputType,
                        textController: textEditingController,

                        isIcon: false,
                        onChanged: (val) {
                          if (textEditingController == txtCtrlBankAcc) {
                            print(val);
                            if (val.length < 9) {
                              isBankAccVerFailed = false;

                            }
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    textEditingController == txtCtrlBankAcc &&
                        txtCtrlBankAcc.text.length > 9
                        ? Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          child: Text(getTranslation(Strings.VERIFY),
                              style: const TextStyle(
                                  color: AppColors.fareColor,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                              textAlign: TextAlign.right),
                          onTap: () {
                            // verify failure
                            setState(() {
                              isBankAccVerFailed = false;
                              txtCtrlAccHolderName.text = "M. AGUS RAHMADI";
                            });
                          },
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 28),
                            width: 54,
                            height: 2,
                            decoration: BoxDecoration(
                                color: const Color(0xffb2f7e2)))
                      ],
                    )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _getDropDownVal(String type) {
    if (type == "transactionType") {
      return transType;
    } else if (type == "paymentSource") {
      return source;
    } else if (type == "frequency") {
      return frequencyType;
    }else if (type == "bankAccount") {
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
    } else if (type == "paymentSource" || type == "bankAccount" ) {
      return arrPaymentSource
          .map<DropdownMenuItem<PaymentSource>>((PaymentSource source) {
        return DropdownMenuItem(
          child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  Image.asset(source.image),
                  Container(
                    width: 8,
                  ),
                  Text(
                    source.bankName,
                    style: TextStyle(
                        color: AppColors.fareColor,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                  )
                ],
              )),
          value: source,
        );
      }).toList();
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
          }else if (type == "bankAccount") {
            bankAccount = val;
          }else
          {
            source = val;
          }
        });
      },
      items: _getDropdownItems(type),
    );
  }

  _getContinueWidget() {
    return
      // InkWell(
      // onTap: () {
      //
      //   // enterMPINBottomSheet();
      //   goToOTPWidget();
      // },
      // child:
      Container(
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
      ).onTap(onPressed: (){
        controller.addBeneficiary(mobile:"9295909790",accountNo: "4545454545454545",bic: "CENAID00001",name:"satheesh");
      });
   // );
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
  void addNewBankAccountBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return AddNewBankAccount();
        });
  }
  void enterMPINBottomSheet() => showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return EnterMPIN( onConfirmTransfer: () async{
          if(widget.selfTransfer){
            push(TransactionDetail());
          }else{
            pop();
            CustomerProfile fromUser = Get.find<AuthController>().user.value.customerProfile;
            Get.find<TransactionController>().sendMoney(Utils().getCustomerProfile(), fromUser, double.parse(controller.txtCtrlTransferAmt.text), pop);
            /* Navigator.pop(context);
          push(ConversationPage(arrChats: ["chat_money_transfer_success"],custInfo: Utils().getCustomerProfile())); //YAKUB Dummy Profile*/

          }
        },);
      });

  Widget getRootContainer() {
    return Scaffold(
      appBar: PreferredSize(
          child: _buildAppBar(context), preferredSize: Size.fromHeight(56.0)),
      body: SafeArea(
          child: Container(
            color: AppColors.background_color,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                      child: getRecepient()
                  ),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTranslation(Strings.TRANSFER_DETAILS),
                                style: const TextStyle(
                                    color: AppColors.fareColor,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0)),
                            textFormFieldContainer(
                                getTranslation(Strings.TRANSFER_AMT),
                                getTranslation(Strings.TRANSFER_AMT_HINT),
                                TextInputType.number,
                                controller.txtCtrlTransferAmt),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 16, bottom: 4),
                                    child: Text(getTranslation(Strings.TRANSACTION_TYPE),
                                        style: BaseStyles
                                            .textFormFieldHeaderTitleTextStyle,
                                        textAlign: TextAlign.left),
                                  ),
                                  _getDropDownList("transactionType"),
                                ]),
                            textFormFieldContainer(
                                getTranslation(Strings.MESSAGE_OPT),
                                getTranslation(Strings.MESSAGE_OPT_HINT),
                                TextInputType.text,
                                txtCtrlTransType),
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
                                      unselectedWidgetColor: Colors.transparent,
                                    ),
                                    child: Checkbox(
                                      activeColor: Colors.transparent,
                                      checkColor: AppColors.header_top_bar_color,
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
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                                  child: Text(getTranslation(Strings.SET_RECURRING),
                                      style: BaseStyles
                                          .textFormFieldHeaderTitleTextStyle,
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                            isToSaveContact ? _getRecurringWidget() : Container()
                          ])),
                  Container(
                      padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
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
                            Text(getTranslation(Strings.PAYMENT_SOURCE),
                                style: const TextStyle(
                                    color: AppColors.fareColor,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0)),
                            _getDropDownList("paymentSource")
                          ])),
                  _getContinueWidget()
                ],
              ),
            ),
          )),
    );
  }
  String phoneNumberValidation(Contact contactInfo) {
    try{
      return contactInfo.phones.elementAt(0).value;
    }catch(Exception){
      return " ";
    }
  }
  String contactNameValidation(String displayName) {
    if(displayName!=null)
      return displayName;
    return "";
  }

  void goToOTPWidget() {
    controller.getOtpForTransfer();

  }
}

class PaymentSource {
  String image;
  String bankName;
}

