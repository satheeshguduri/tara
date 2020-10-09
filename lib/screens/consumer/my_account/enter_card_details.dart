import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/text_field_widget.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/my_account/create_mpin_screen.dart';

class EnterCardDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EnterCardDetailsState();
  }
}

class _EnterCardDetailsState extends BaseState<EnterCardDetails> {
  TextEditingController txtCtrlBankAcc = TextEditingController();

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
          ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.connect_new_account),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8),
              child:
                  TextWithBottomOverlay(titleStr: Strings.enter_card_details),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: textFormFieldContainer(
                  getTranslation(Strings.card_number),
                  getTranslation(Strings.card_number_ex),
                  TextInputType.number,
                  txtCtrlBankAcc),
            ),
            Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                      getTranslation(Strings.expired_date),
                                      style: BaseStyles
                                          .textFormFieldHeaderTitleTextStyle,
                                      textAlign: TextAlign.left),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: textFormFieldContainer(
                                              "",
                                              getTranslation(Strings.mm),
                                              TextInputType.number,
                                              txtCtrlBankAcc),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "/",
                                        style: TextStyle(
                                          color: AppColors.light_grey_blue,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: textFormFieldContainer(
                                              "",
                                              getTranslation(Strings.yy),
                                              TextInputType.number,
                                              txtCtrlBankAcc),
                                        )),
                                  ],
                                ),
                              ]),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(getTranslation(Strings.cvv),
                                      style: BaseStyles
                                          .textFormFieldHeaderTitleTextStyle,
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  child: textFormFieldContainer(
                                      "",
                                      getTranslation(Strings.cvv),
                                      TextInputType.number,
                                      txtCtrlBankAcc),
                                ),
                              ]),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                    ),
                  ],
                )),
          ]),
          getConfirmWidget()
        ],
      )),
    );
  }

  getConfirmWidget() {
    return Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 32, top: 8, left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.bottom_border_color),
        alignment: Alignment.center,
        child: InkWell(
            onTap: () {
              push(CreateMPIN());
            },
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: Text(
                getTranslation(Strings.CONTINUE),
                textAlign: TextAlign.center,
                style: BaseStyles.cannotFindTextStyle,
              ),
            )));
  }

  textFormFieldContainer(String headerTitle, String hint,
      TextInputType inputType, TextEditingController textEditingController) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.light_grey_blue,
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
                    style: BaseStyles.textFormFieldHeaderTitleTextStyle,
                    textAlign: TextAlign.left),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFieldWidget(
                        placeHolderStyle: BaseStyles.placeholderStyle,
                        hint: hint,
                        inputType: inputType,
                        textController: textEditingController,
                        isIcon: false,
                        onChanged: (val) {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }
}
