import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/borders.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/textfield_widget.dart';
import 'package:tara_app/screens/Merchant/cash_deposit_select_contact.dart';
import 'package:tara_app/screens/base/base_state.dart';

class CashDepositWidget extends StatefulWidget {
  CashDepositWidget({Key key}) : super(key: key);

  @override
  _CashDepositWidgetState createState() => _CashDepositWidgetState();
}

class _CashDepositWidgetState extends BaseState<CashDepositWidget> {

  TextEditingController depositTextController = TextEditingController();
  TextEditingController remarksTextController = TextEditingController();
  TextEditingController contactNameTextController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isSwitched = false;

  @override
  BuildContext getContext() {
    return this.context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: updateViews()
    );

  }

  updateViews()
  {
    return Container(
      child: Column(
        children: [
          Container(
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
                Strings.CASH_DEPOSIT,
                style:BaseStyles.bottomSheetTitleStyle,
               textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                          Strings.SELECT_LOCATION,
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
                                        "Jl. Kedoya Raya, Kota Jakarta Barat, Daerah Khusus Ibukota …",
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
                              child: Container(
                                padding: EdgeInsets.only(top: 8,bottom: 8),
                                child: Column(
                                  children: [
                                    Text(
                                        Strings.CHANGE,
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
                          ],
                        ),
                      ),
                    ),
                    textFormFieldContainer(Strings.DEPOSIT_AMOUNT,Strings.RP,TextInputType.number,depositTextController),
                    textFormFieldContainer(Strings.REMARKS_OPTIONAL,Strings.LOCATION_REMARKS_HINT,TextInputType.text,remarksTextController),
                    addAdditionalContactSwitch(),
                    isSwitched==true?textFormFieldContainer(Strings.CONTACT_NAME,Strings.CONTACT_NAME_HINT,TextInputType.text,contactNameTextController):Container(),
                    isSwitched==true?textFormFieldContainer(Strings.PHONE_NUMBER,Strings.PHONE_NUMBER_HINT,TextInputType.phone,phoneNumberController):Container(),
                    requestNowWidget()
                  ],
                ),
              ),),),
        ],
      ),
    );
  }

  textFormFieldContainer(String headerTitle, String hint, TextInputType inputType, TextEditingController textEditingController)
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
                    child: TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,),
                  ),
                  textEditingController == contactNameTextController?Expanded(
                      flex: 2.toInt(),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CashDepositSelectContact()),
                          );
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
                "Add additional contact (optional)",
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

        },
      child: Container(
          height: 48,
          margin: EdgeInsets.only(bottom: 16,top: 24,left: 8,right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
              color: const Color(0xffe9ecef)
          ),
          alignment: Alignment.center,
          child: Text(
            Strings.REQUEST_NOW,
            textAlign: TextAlign.center,
            style: BaseStyles.requestNowTextStyle,
          ),
      ),
    );
  }

}