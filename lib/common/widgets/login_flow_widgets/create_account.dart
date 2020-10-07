import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/Data.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({
    Key key,
  }) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends BaseState<CreateNewAccount> {

  static List<String> countryNamesList = ["australia", "brazil", "canada", "france","germany", "india", "indonesia", "ireland","uk","usa"];
  static List<String> countryCodesList = ["+61", "+55", "+1", "+33","+49", "+91", "+62", "+353","+44","+1"];
  static List<String> imgList = [
    Assets.ic_australia_flag,
    Assets.ic_brazil_flag,
    Assets.ic_canada_flag,
    Assets.ic_france_flag,
    Assets.ic_germany_flag,
    Assets.ic_india_flag,
    Assets.ic_indonesia_flag,
    Assets.ic_ireland_flag,
    Assets.ic_uk_flag,
    Assets.ic_usa_flag,
  ];

  List<CountryCodeModel> arrCountries = List<CountryCodeModel>();

  CountryCodeModel dropdownValue;
  TextEditingController mobileNoController = TextEditingController();
  FocusNode mobileNorFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.90,
      child: Container(
        padding: EdgeInsets.only(left: 20,right: 16,top: 8,bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
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
            Container(
              width: 62,
              height: 24,
              margin: EdgeInsets.only(top: 16,bottom: 8),
              child: Image.asset(
                "assets/images/combined-shape-5.png",
                fit: BoxFit.none,
              ),
            ),
            TextWithBottomOverlay(titleStr: Strings.CREATE_ACCOUNT,),
            Container(
              color: Colors.grey[200],
              height: 1,
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                  getTranslation(Strings.HELLO),
                  style: BaseStyles.backAccountHeaderTextStyle
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                  getTranslation(Strings.PLEASE_ENTER_MOBILE),
                  style: BaseStyles.subHeaderTextStyle
              ),
            ),
            textFormFieldContainer(getTranslation(Strings.PHONE_NUMBER),TextInputType.phone,mobileNoController,mobileNorFocusNode),
            _getContinueWidget()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData()
  {
    arrCountries = List<CountryCodeModel>();
    for (var i = 0; i < countryNamesList.length; i++) {
      var country = CountryCodeModel();
      country.countryName = countryNamesList[i];
      country.image = imgList[i];
      country.countryCode = countryCodesList[i];
      arrCountries.add(country);
    }

    dropdownValue = arrCountries.first;
  }

  textFormFieldContainer(String hint,TextInputType inputType, TextEditingController textEditingController,FocusNode focusNode)
  {
    return Container(
        margin: EdgeInsets.only(top:8),
        child: Container(
          child:Row(
            children: [
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide( //                   <--- left side
                          color: Colors.grey[400],
                          width: 1.0,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                    child: _getDropDownList(),
                  ),
                ],
              ),
              Expanded(
                flex:6.2.toInt(),
                child:Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide( //                   <--- left side
                        color: Colors.grey[400],
                        width: 1.0,
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                  child:TextFieldWidget(hint: hint,inputType: inputType,textController: textEditingController,isIcon: false,focusNode: focusNode,onChanged:(value){

                  }),
                )
              ),
            ],
          ),
        )
    );
  }

  _getDropDownList() {
    return DropdownButton<CountryCodeModel>(
      icon: Image.asset(Assets.ic_dropdown,width: 18,),
      value: dropdownValue,
      style: BaseStyles.subHeaderTextStyle,
      underline: Container(),
      onChanged: (val) {
        setState(() {
          dropdownValue = val;
        });
      },
      items: _getDropdownItems(),
    );
  }

  _getDropdownItems() {
    return arrCountries
        .map<DropdownMenuItem<CountryCodeModel>>((CountryCodeModel countryCodeModel) {
      return DropdownMenuItem<CountryCodeModel>(
        child: Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                Image.asset(countryCodeModel.image,width: 18,height: 18,),
                Container(
                  width: 3,
                ),
                Text(
                  countryCodeModel.countryCode,
                  style: BaseStyles.subHeaderTextStyle,
                  textAlign: TextAlign.center,
                )
              ],
            )),
        value: countryCodeModel,
      );
    }).toList();
  }

  _getContinueWidget() {
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, top: 24,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.bottom_border_color),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.CONTINUE),
          textAlign: TextAlign.center,
          style: BaseStyles.addNewBankAccount,
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

}
