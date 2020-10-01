import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/drop_down_list.dart';
import 'package:tara_app/common/widgets/textfield_widget.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/utils/locale/utils.dart';

class AddNewBankAccount extends StatefulWidget {
  AddNewBankAccount({Key key}) : super(key: key);

  @override
  _AddNewBankAccountState createState() => _AddNewBankAccountState();
}

class _AddNewBankAccountState extends BaseState<AddNewBankAccount> {

  TextEditingController bankNameTextController = TextEditingController();
  TextEditingController bankAccountNumberTextController = TextEditingController();
  TextEditingController bankHolderNameController = TextEditingController();
  var selectedBankFromList = BankInfo();
  bool isVerified = false;
  bool isToShowList = false;
  bool isToSaveContact = false;
  FocusNode bankAccountNumberFocusNode = new FocusNode();

  List<BankInfo> arrBankInfo = List();
  List<BankInfo> arrFilterBankInfo = List();
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

  @override
  BuildContext getContext() {
    return this.context;
  }

  @override
  void initState() {
    super.initState();
    addListenersToRequiredTextField();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Container(
          margin: EdgeInsets.only(left: 16,right: 16),
          child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4,bottom: 8),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 209, 212, 215),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    Strings.ADD_NEW_BANK_ACCOUNT,
                    style:BaseStyles.bottomSheetTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                textFormFieldContainer(Strings.BANK_NAME,Strings.ENTER_BANK_NAME,TextInputType.text,bankNameTextController,selectedBankFromList,null),
                (isToShowList==true && arrFilterBankInfo.length > 0)?Container(
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
                isToShowList==false?textFormFieldContainer(Strings.BANK_ACCOUNT_NUMBER,Strings.ENTER_BANK_ACCOUNT_NUMBER,TextInputType.number,bankAccountNumberTextController,selectedBankFromList,bankAccountNumberFocusNode):Container(),
                isToShowList==false?isVerified==true?textFormFieldContainer(Strings.BANK_HOLDER_NAME,"",TextInputType.text,bankHolderNameController,selectedBankFromList,null):Container():Container(),
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
                            Strings.SAVE_TO_MY_CONTACT,
                            style: BaseStyles.saveToMyContactTextStyle,
                            textAlign: TextAlign.left
                        ),),
                    ],
                  ) ,
                ),
                addNewBankAccountWidget()
              ])
      ),
    );

  }

  addListenersToRequiredTextField() {
    bankAccountNumberFocusNode.addListener(() {
      bool hasFocus = bankAccountNumberFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  void loadData() {
    arrBankInfo = List();

    for (var i = 0; i < arrBankNames.length; i++) {
      var bank = BankInfo();
      bank.bankName = arrBankNames[i];
      bank.bankIcon = arrBankIcons[i];
      arrBankInfo.add(bank);
    }
  }

  onChanged(TextEditingController textEditingController)
  {
    if (textEditingController==bankNameTextController)
    {
     var _searchText = textEditingController.text;
      if (_searchText != null &&
          _searchText.toString().isNotEmpty &&
          _searchText.toString().length > 2) {
        arrFilterBankInfo = List();
        if (arrBankInfo.length > 0) {
          arrFilterBankInfo = arrBankInfo
              .where((bank) => bank.bankName
              .toLowerCase()
              .contains(_searchText.toLowerCase()))
              .toList();
          if (arrFilterBankInfo.length > 0) {
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
  }

  textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController,BankInfo bankInfo,FocusNode focusNode)
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
          color: Colors.transparent,
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
                      flex: textEditingController == bankAccountNumberTextController?7.5.toInt():1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: (bankInfo!=null&&bankInfo.bankIcon!=null&&bankInfo.bankIcon!=""
                                &&textEditingController != bankAccountNumberTextController
                                &&textEditingController != bankHolderNameController)?2.5.toInt():0,
                            child:(bankInfo!=null&&bankInfo.bankIcon!=null&&bankInfo.bankIcon!=""
                                &&textEditingController != bankAccountNumberTextController
                                &&textEditingController != bankHolderNameController)?Align(
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
                                &&textEditingController != bankAccountNumberTextController
                                &&textEditingController != bankHolderNameController)?7.5.toInt():1,
                            child:TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){
                              onChanged(textEditingController);
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: textEditingController == bankAccountNumberTextController?2.5.toInt():0,
                      child: textEditingController == bankAccountNumberTextController?
                      InkWell(onTap: (){
                        Utils().hideKeyBoard(context);
                        if (bankNameTextController!=null && bankNameTextController.text.length>0 &&
                            bankAccountNumberTextController!=null && bankAccountNumberTextController.text.length>0)
                        {
                          setState(() {
                            isVerified = true;
                            bankHolderNameController.text = "M. AGUS RAHMADI";
                          });
                        }
                      },child: Container(
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child: Column(
                            children: [
                              Text(
                                  Strings.VERIFY,
                                  style: BaseStyles.bottomSheetLocationChangeTextStyle,
                                  textAlign: TextAlign.center
                              ),
                              Container(
                                height:2 ,
                                margin: EdgeInsets.only(top: 4,left: 8,right: 8),
                                decoration: BoxDecoration(
                                  gradient: Gradients.primaryGradient,
                                ),
                              ),
                            ],
                          )
                      ),):Container()
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  addNewBankAccountWidget()
  {
    return InkWell(
      onTap: (){
        Utils().hideKeyBoard(context);
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16,top: 8,left: 8,right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            color: AppColors.bottom_border_color
        ),
        alignment: Alignment.center,
        child: Text(
          Strings.ADD_NEW_BANK_ACCOUNT,
          textAlign: TextAlign.center,
          style: BaseStyles.addNewBankAccount,
        ),
      ),
    );
  }

}
