import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/add_new_bank_account.dart';
import 'package:tara_app/screens/consumer/transfer_contacts_selection_screen.dart';
import 'package:tara_app/screens/consumer/enter_mpin.dart';
import 'package:tara_app/screens/consumer/transaction_detail_screen.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_widget_controller.dart';
import 'package:tara_app/screens/merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:tara_app/models/auth/registration_status.dart';
import 'package:tara_app/screens/consumer/add_beneficiary_screen.dart';
import 'package:tara_app/controller/contacts_transfer_controller.dart';

class TransferDetailsEntryScreen extends StatefulWidget {

  final CustomerProfile toCustomerProfile;
  TransferDetailsEntryScreen({Key key,this.toCustomerProfile,RequestType requestType}) : super(key: key);



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
  num selfAccountTokenId;
  var formKey = GlobalKey<FormState>();



  List<String> transTypeList = ["Others", "Others1", "Others2"];
  List<String> arrFrequency = [Strings.DAILY, Strings.MONTHLY, Strings.YEARLY];

  ContactsTransferController contactsController = Get.find();



  String frequencyType;
  String transType;
  bool isSelf;
  PaymentSource source;
  PaymentSource bankAccount;
  bool isToSaveContact = false;
  bool isBankAccVerFailed = false;
  BankAccountContactInfo contactInfo;

  // Contact taraContact;

  @override
  BuildContext getContext() => context;

  @override
  void initState() {
    super.initState();
    uiController.getCustomerBankAccounts();
    var user = Get.find<AuthController>().user;
    isSelf = widget.toCustomerProfile.mobileNumber == user.value.customerProfile.mobileNumber;
    print(widget.toCustomerProfile.registrationStatus);
  }
  bool isTaraUser(CustomerProfile customerProfile) {
    return customerProfile.registrationStatus == RegistrationStatus.TARA;
  }
  Widget getReciepentHeaderWidget() {
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
                          widget?.toCustomerProfile?.firstName??"",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                      Visibility(visible:isTaraUser(widget.toCustomerProfile),child: Image.asset(
                        Assets.tara_contacts,
                        height: 32,
                        width: 32,
                      ))
                    ],),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        widget.toCustomerProfile.mobileNumber,
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
    return Obx(() =>
        SafeArea(
            child: getRootContainer().withProgressIndicator(
                showIndicator: transactionController.showProgress.value)));
  }

  dynamic _getDropDownVal(String type) {
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

  Widget _getDropDownHint(String type) {
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

  List _getDropdownItems(String type) {
    if (type == "transactionType") {
      return transTypeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          child: (Text(value)),
          value: value,
        );
      }).toList();
    } else if (type == "paymentSource" || type == "bankAccount") {
      return (uiController.mappedItems).map((
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

  Widget _getDropDownList(String type) {
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

  Widget _getContinueWidget() {
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
      if(formKey.currentState.validate()) {

        if(isSelf){
          // if (uiController.selectedSelfAccount.value?.beneId?.isNullOrBlank??false) {
          uiController.confirmToPay(
              // mobile: widget.customerProfile.mobileNumber,
              amount: uiController.amountController.text,
              remarks: uiController.messageController.text,
              bic: bic,
              cvv: uiController.cvvController.text,
              accountTokenId: accountTokenId,
              selfAccountId: selfAccountTokenId,
              selectedSourceBankAccount:selectedSourceBankAccount
            //  beneId: 44 //getBenId(widget.beneContact)
          );

        }
        else if (uiController.selectedBenAccount?.value!=null) {
            uiController.confirmToPay(
                mobile: widget.toCustomerProfile.mobileNumber,
                amount: uiController.amountController.text,
                remarks: uiController.messageController.text,
                bic: bic,
                cvv: uiController.cvvController.text,
                accountTokenId: accountTokenId,
                beneId: uiController.selectedBenAccount.value
                    .beneId, //getBenId(widget.beneContact)
                selectedSourceBankAccount:selectedSourceBankAccount
            );
          }else{
          uiController.confirmToPay(
              mobile: widget.toCustomerProfile.mobileNumber,
              amount: uiController.amountController.text,
              remarks: uiController.messageController.text,
              bic: bic,
              cvv: uiController.cvvController.text,
              accountTokenId: accountTokenId,
              selectedSourceBankAccount:selectedSourceBankAccount
          );
        }
      }else{
        showToast(message: "Please Add a bank account");
      }
    });
  }

  String getFrequencyStartTitle() {
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

  String getFrequencyEndTitle() {
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

  Widget _getStartEndWidget(bool isStart) {
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

  Widget _createFrequencyWidget() {
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

  Widget _getRecurringWidget() {
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
                              //made visibility false for this perticular recurring widget as per hari
                              Visibility(
                                visible: false,
                                child: Row(
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

  Widget getCustomItemWidget(String bankname, String maskedAccountNumber) {
    return Row(
      children: [
        Container(margin: EdgeInsets.only(right: 8),
            child: Image.asset(Assets.ic_bca,)),
        Text(bankname + " - " +
            Utils().getMaskedAccountNumber(maskedAccountNumber),
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
    return Column(
      children: [
        Container(
          //  margin: EdgeInsets.only(top: 8, bottom: 8),
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
            child: getReciepentHeaderWidget()
        ),
        getPaymentToSelfWidget(),
       Obx(()=> contactsController.arrRecentlyAddedContactInfo.length>0?getSelectBeneAccountWidget():Container()),
        Container( color: AppColors.primaryBackground,height: 16,),
        getAddNewAccountWidget(),
      ],
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


  var selectedSourceBankAccount;
  Widget getPaymentSourceWidget() {
    return
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslation(Strings.PAYMENT_SOURCE),
                style:TextStyles.transferDetailsHeadingTextStyle),

            DropdownButtonFormField<MappedBankAccountsBean>(
                decoration: removeUnderlineAndShowHint(""),
                icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),
                style: TextStyles.inputFieldOn222,
                isExpanded: true,
                value: selectedSourceBankAccount,
                items: (uiController.mappedItems)?.map((MappedBankAccountsBean item) {
                  bic = item.bic;
                  accountTokenId = item.accountTokenId;
                  return DropdownMenuItem<MappedBankAccountsBean>(
                    value: item,
                    child: getCustomItemWidget(item.bankName,item.maskedAccountNumber),
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      bic = item.bic;
                      accountTokenId = item.accountTokenId;
                      selectedSourceBankAccount = item;
                    },
                  );
                })?.toList()??[],
                onChanged: (val){
                  selectedSourceBankAccount = val;
                }

            ),
          ],
        ),

      );
    // );
  }

  Widget getPaymentToSelfWidget() {

    return isSelf?
    Container(
      color: AppColors.primaryBackground,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),

      height: 78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment To",
              style:TextStyles.transferDetailsHeadingTextStyle),

          DropdownButtonFormField<MappedBankAccountsBean>(
              decoration: removeUnderlineAndShowHint(""),
              icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,width: 24.0,height: 24.0),
              style: TextStyles.inputFieldOn222,
              isExpanded: true,
              value:(uiController.mappedItems?.isNotEmpty??false)?uiController.mappedItems[0]:null,
              items:(uiController.mappedItems)?.map((MappedBankAccountsBean item) {
                //   selfAccountTokenId = item.accountTokenId;
                return DropdownMenuItem<MappedBankAccountsBean>(
                  value:item,
                  child: getCustomItemWidget(item.bankName,item.maskedAccountNumber),
                  onTap: (){
                    selfAccountTokenId = item.accountTokenId;
                  },
                );
              })?.toList()??[],
              onChanged: (value){
                uiController.selectedSelfAccount.value = value;

              }

          ),
          getTheDivider(),
        ],
      ),

    ):Container();
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

  Widget getSelectBeneAccountWidget() {

    if(widget.toCustomerProfile.registrationStatus == RegistrationStatus.BENEFICIARY){
      return Container(
          color: AppColors.primaryBackground,
          padding: EdgeInsets.only(left:16,right:16,),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonTextWidget("Select Account"),
                getAccountsDropDownList(),
                getTheDivider(),
              ]
          )

      );
    }else return Container();
  }

  Widget getAddNewAccountWidget() {

    if(widget.toCustomerProfile.registrationStatus == RegistrationStatus.BENEFICIARY || widget.toCustomerProfile.registrationStatus == RegistrationStatus.INACTIVE){
      return Container(
        color: AppColors.primaryBackground,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.only(bottom: 16),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 16,right: 16),
          padding: EdgeInsets.only(bottom: 12, top: 12),
          decoration: BoxDecoration(

              border: Border.all( color: Colors.grey,),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),

          child: Text(" + Add New Bank Account"),

        ),
      ).onTap(onPressed: (){

        Get.to(AddBeneficiaryScreen(customerProfile: widget.toCustomerProfile,isNewUser: contactsController.arrRecentlyAddedContactInfo?.isEmpty??true));
      });

    }else{
      return Container();
    }
  }

  Widget getAccountsDropDownList() {
    uiController.selectedBenAccount.value = contactsController?.arrRecentlyAddedContactInfo[0];
    return Container(
      height: 48,
      child:Obx(()=> DropdownButtonFormField<BeneDetailBean>(
        decoration: removeUnderlineAndShowHint(""),
        icon: getSvgImage(imagePath: Assets.assets_icon_a_arrow_down,
            width: 24.0,
            height: 24.0),
        style: TextStyles.inputFieldOn222,
        value: contactsController.arrRecentlyAddedContactInfo[0],
        isExpanded: true,
        onChanged: (value) {
          uiController.selectedBenAccount.value = value;
        },
        items:contactsController.arrRecentlyAddedContactInfo.map((BeneDetailBean value) {
          return DropdownMenuItem<BeneDetailBean>(
            value: value,
            child:  getCustomItemWidget("",value.beneAccountNo),
            onTap: (){
              uiController.selectedBenAccount.value = value;
            },
          );
        }).toList()??[],

      ),
    ));
  }
}

class PaymentSource {
  String image;
  String bankName;
}

