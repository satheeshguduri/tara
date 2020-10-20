import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/screens/Merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:tara_app/screens/map_screen.dart';

class CashDepositWidget extends StatefulWidget {
  final ChatInboxInfo chatInboxInfo;
  final Function(ChatInboxInfo) chatInboxInfoCallBack;
  CashDepositWidget({Key key,this.chatInboxInfo,this.chatInboxInfoCallBack}) : super(key: key);

  @override
  _CashDepositWidgetState createState() => _CashDepositWidgetState();
}

class _CashDepositWidgetState extends BaseState<CashDepositWidget> {

  TextEditingController depositTextController = TextEditingController();
  TextEditingController remarksTextController = TextEditingController();
  TextEditingController contactNameTextController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isSwitched = false;
  FocusNode depositTextFocusNode = new FocusNode();
  FocusNode phoneNumberFocusNode = new FocusNode();
  var addressStr = "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …";
  ContactInfo selectedContactInfo;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child:Container(
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
                      getTranslation(Strings.CASH_DEPOSIT),
                      style:BaseStyles.bottomSheetTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                        getTranslation(Strings.SELECT_LOCATION),
                        style: BaseStyles.bottomSheetSubTitleStyle
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.only(left: 8,bottom: 8,top: 8,right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)
                        ),
                        border: Border.all(
                            color: Color(0xffe9ecef),
                            width: 1
                        ),
                        color: Color(0xffffffff)
                    ),
                    child:Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7.5.toInt(),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    Assets.ic_location,
                                    fit: BoxFit.none,
//                            color: Colors.black54,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8,right: 8),
                                    child: Text(
                                      addressStr,
                                      style: BaseStyles.bottomSheetLocationStyle,
                                      maxLines: 3,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2.5.toInt(),
                            child: InkWell(
                              onTap: (){
                              /*  push(MapScreen(address:addressStr,addressCallback:(address){
                                  setState(() {
                                    addressStr = address;
                                  });
                                })); */
                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 8,bottom: 8),
                                  child: Column(
                                    children: [
                                      Text(
                                          getTranslation(Strings.CHANGE),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  textFormFieldContainer(getTranslation(Strings.DEPOSIT_AMOUNT),getTranslation(Strings.RP),TextInputType.number,depositTextController,depositTextFocusNode),
                  textFormFieldContainer(getTranslation(Strings.REMARKS_OPTIONAL),getTranslation(Strings.LOCATION_REMARKS_HINT),TextInputType.text,remarksTextController,null),
                  addAdditionalContactSwitch(),
                  isSwitched==true?textFormFieldContainer(getTranslation(Strings.CONTACT_NAME),getTranslation(Strings.CONTACT_NAME_HINT),TextInputType.text,contactNameTextController,null):Container(),
                  isSwitched==true?textFormFieldContainer(getTranslation(Strings.PHONE_NUMBER),getTranslation(Strings.PHONE_NUMBER_HINT),TextInputType.phone,phoneNumberController,phoneNumberFocusNode):Container(),
                  requestNowWidget(),
                ])
        )
    ),);

  }

  @override
  initState() {
    super.initState();
    addListenersToRequiredTextField();
  }

  addListenersToRequiredTextField() {
    depositTextFocusNode.addListener(() {
      bool hasFocus = depositTextFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });

    phoneNumberFocusNode.addListener(() {
      bool hasFocus = phoneNumberFocusNode.hasFocus;
      if (hasFocus)
        Utils().showOverlay(context);
      else
        Utils().removeOverlay();
    });
  }

  textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController,FocusNode focusNode)
  {
    return Container(
      margin: textEditingController == contactNameTextController?EdgeInsets.only(top:0):EdgeInsets.only(top:8),
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
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: textEditingController == contactNameTextController?8.toInt():1,
                    child: TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){
                      if (textEditingController == depositTextController)
                      {
                        setState(() {

                        });
                      }
                    }),
                  ),
                  textEditingController == contactNameTextController?Expanded(
                      flex: 2.toInt(),
                      child: InkWell(
                        onTap: (){
                          push(CashDepositSelectContact(isFromCashDeposit:true,selectedContactCallback: (contactInfoTemp){
                            setState(() {
                              selectedContactInfo = contactInfoTemp;
                              contactNameTextController.text = selectedContactInfo.name;
                              phoneNumberController.text = selectedContactInfo.phoneNumber;
                            });
                          },));
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            Assets.ic_contact,
                            fit: BoxFit.none,
//                      color: Colors.black54,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      )
                  ):Container(),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  addAdditionalContactSwitch()
  {
    return Container(
      margin: EdgeInsets.only(top:8,bottom:8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8,bottom: 8),
            child: Text(
                getTranslation(Strings.ADD_ADDITIONAL_CONTACT),
                style: BaseStyles.additionContactTextTextStyle,
                textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeTrackColor: Color(0xffb2f7e2),
              activeColor: Color(0xffffffff),
            ),
          ),

        ],
      ),
    );
  }

  requestNowWidget()
  {
    return InkWell(
        onTap: (){
          if(depositTextController.text.toString().trim().isNotEmpty)
          {
            if (widget.chatInboxInfo!=null)
            {
              widget.chatInboxInfo.chatAmount = depositTextController.text;
              widget.chatInboxInfo.chatCardTitle = "chat_request_cash_deposit";
              widget.chatInboxInfoCallBack(widget.chatInboxInfo);
              Navigator.pop(context);
            }else{
              ChatInboxInfo chatInboxInfo = ChatInboxInfo();
              chatInboxInfo.chatTitle = getTranslation(Strings.CASH_DEPOSIT);
              chatInboxInfo.chatAmount = depositTextController.text;
              chatInboxInfo.chatCardTitle = "chat_request_cash_deposit";
              widget.chatInboxInfoCallBack(chatInboxInfo);
              Navigator.pop(context);
            }
          }
        },
      child: Container(
          height: 48,
          margin: EdgeInsets.only(bottom: 16,top: 24,left: 8,right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
              color: (depositTextController.text.toString().trim().isNotEmpty)?Color(0xffb2f7e2):Color(0xffe9ecef)
          ),
          alignment: Alignment.center,
          child: Text(
            getTranslation(Strings.REQUEST_NOW),
            textAlign: TextAlign.center,
            style: (depositTextController.text.toString().trim().isNotEmpty)?BaseStyles.mobileNoTextStyle:BaseStyles.requestNowTextStyle,
          ),
      ),
    );
  }

}