import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/textfield_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';

import 'Data.dart';

class BankTransferNewContact extends StatefulWidget {
  BankTransferNewContact({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BankTransferNewContactState createState() => _BankTransferNewContactState();
}

class _BankTransferNewContactState extends BaseState<BankTransferNewContact> {
  TextEditingController txtCtrlBankName = TextEditingController();
  TextEditingController txtCtrlBankAcc = TextEditingController();
  TextEditingController txtCtrlTransferAmt = TextEditingController();
  TextEditingController txtCtrlTransType = TextEditingController();

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

  String frequencyType;
  String transType;
  PaymentSource source;
  BankModel selectedbank;
  bool isToSaveContact = false;
  bool isBankAccVerFailed = false;

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.RECEIPENT,
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0)),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8, bottom: 4),
                                child: Text(Strings.BANK_NAME,
                                    style: BaseStyles
                                        .textFormFieldHeaderTitleTextStyle,
                                    textAlign: TextAlign.left),
                              ),
                              TypeAheadFormField(
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                    style:
                                        TextStyle(color: AppColors.fareColor),
                                    controller: this._typeAheadController,
                                    decoration: InputDecoration(
                                        prefixIcon: selectedbank != null
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                                child: Image.asset(
                                                  selectedbank.image,
                                                  width: 24,
                                                ),
                                              )
                                            : Container(),
                                        labelStyle: BaseStyles
                                            .textFormFieldHeaderTitleTextStyle,
//                                  labelText: Strings.BANK_NAME,
                                        hintText: Strings.BANK_NAME_HINT)),
                                suggestionsCallback: (pattern) {
                                  return BankList.getSuggestions(pattern);
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    leading: Image.asset(suggestion.image),
                                    title: Text(suggestion.bankName),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (suggestion) {
                                  setState(() {
                                    selectedbank = suggestion;
                                    this._typeAheadController.text =
                                        selectedbank.bankName;
                                  });
                                },
//                              validator: (value) =>
//                              value.isEmpty ? 'Please select a city' : null,
                              ),
                            ]),
//                            textFormFieldContainer(Strings.BANK_NAME, Strings.BANK_NAME_HINT, TextInputType.text, txtCtrlBankName),
                        textFormFieldContainer(
                            Strings.BANK_ACC_NO,
                            Strings.BANK_ACC_NO_HINT,
                            TextInputType.text,
                            txtCtrlBankAcc),
                        isBankAccVerFailed
                            ? Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Text(
                                  Strings.error_verify_bank_account,
                                  style: BaseStyles.error_text_style,
                                ),
                              )
                            : Container(),
                      ])),
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
                        Text(Strings.TRANSFER_DETAILS,
                            style: const TextStyle(
                                color: AppColors.fareColor,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0)),
                        textFormFieldContainer(
                            Strings.TRANSFER_AMT,
                            Strings.TRANSFER_AMT_HINT,
                            TextInputType.text,
                            txtCtrlTransferAmt),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 16, bottom: 4),
                                child: Text(Strings.TRANSACTION_TYPE,
                                    style: BaseStyles
                                        .textFormFieldHeaderTitleTextStyle,
                                    textAlign: TextAlign.left),
                              ),
                              _getDropDownList("transactionType"),
                            ]),
                        textFormFieldContainer(
                            Strings.MESSAGE_OPT,
                            Strings.MESSAGE_OPT_HINT,
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
                              child: Text(Strings.SET_RECURRING,
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
                        Text(Strings.PAYMENT_SOURCE,
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

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      centerTitle: false,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                                child: Text(Strings.VERIFY,
                                    style: const TextStyle(
                                        color: AppColors.fareColor,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.0),
                                    textAlign: TextAlign.right),
                                onTap: () {
                                  // verify failure
                                  setState(() {
                                    isBankAccVerFailed = true;
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
    }
  }

  _getDropDownHint(String type) {
    if (type == "transactionType") {
      return Text(Strings.TRANSACTION_TYPE_HINT);
    } else if (type == "paymentSource") {
      return Container();
    } else if (type == "frequency") {
      return Text(Strings.TRANSACTION_TYPE_HINT);
      ;
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
    } else if (type == "paymentSource") {
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
          } else {
            source = val;
          }
        });
      },
      items: _getDropdownItems(type),
    );
  }

  _getContinueWidget() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 24, left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: const Color(0xffe9ecef)),
        alignment: Alignment.center,
        child: Text(
          Strings.CONTINUE,
          textAlign: TextAlign.center,
          style: BaseStyles.requestNowTextStyle,
        ),
      ),
    );
  }

  getFrequencyStartTitle() {
    if (frequencyType == Strings.DAILY) {
      return Strings.START_DATE;
    } else if (frequencyType == Strings.MONTHLY) {
      return Strings.START_MONTH;
    } else if (frequencyType == Strings.YEARLY) {
      return Strings.START_YEAR;
    } else {
      return "";
    }
  }

  getFrequencyEndTitle() {
    if (frequencyType == Strings.DAILY) {
      return Strings.END_DATE;
    } else if (frequencyType == Strings.MONTHLY) {
      return Strings.END_MONTH;
    } else if (frequencyType == Strings.YEARLY) {
      return Strings.END_YEAR;
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
                    Text(Strings.FREQUENCY,
                        style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                        textAlign: TextAlign.left),
                    _getDropDownList("frequency")
                  ])),
          _createFrequencyWidget()
        ],
      ),
    ));
  }
}

class PaymentSource {
  String image;
  String bankName;
}
