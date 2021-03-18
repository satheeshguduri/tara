import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/common/widgets/account_info_card_row.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/otp_text_field_widget.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/to_address_response.dart';
import 'package:tara_app/models/order_management/orders/order_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/device_info.dart' as device;
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/screens/base/base_state.dart';


class OTPVerificationScreen extends StatefulWidget {
  final String txnId;
  final FetchOtpResponse fetchOtpResponse;
  final RetrieveKeyResponse retrieveKeyResponse;
  final device.DeviceInfoBean deviceInfoBean;
  final String bic;
  final VerificationType verificationType;
  final num amount;
  final CustomerProfile toAddress;
  final MappedBankAccountsBean selectedSourceBankAccount;
  final OrderRequest orderRequest;
  const OTPVerificationScreen(
      {this.txnId,
      this.fetchOtpResponse,
      this.retrieveKeyResponse,
      this.deviceInfoBean,
      this.bic,
      this.verificationType,
      this.amount,
      this.toAddress,
      this.selectedSourceBankAccount,this.orderRequest});

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends BaseState<OTPVerificationScreen> {
  bool isOtpEntered = false;

  TransactionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(
        title: getTranslation(Strings.inputOTP),
        addNewWidgetShow: false,
      ),
      body: getRootContainer(),
    );
  }

  Widget getRootContainer() {
    return Obx(() => SafeArea(
          child: SingleChildScrollView(reverse: true, child: getOtpWidget())
              .withProgressIndicator(
                  showIndicator: controller.showProgress.value),
        ));
  }

  Widget getOtpWidget() {
    return Container(
      height: Get.height - 88,
      child: Column(
        children: [
          // Visibility(
          //   visible: widget.from!="addaccount",
          //   child: Container(
          //     padding: EdgeInsets.only(bottom:16),
          //     child: AccountInfoCardRow(data: widget.selectedSourceBankAccount,),
          //     // child: CustomCard(image:Assets.ic_mpin_card,bankIcon: Assets.ic_mandiri,accountName: widget.mappedBankAccountsBean.bankName,accountNumber: Utils().getMaskedAccountNumber(widget.mappedBankAccountsBean.maskedAccountNumber),),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(bottom: 16),
            child: AccountInfoCardRow(
              data: widget.selectedSourceBankAccount,
            ),
            // child: CustomCard(image:Assets.ic_mpin_card,bankIcon: Assets.ic_mandiri,accountName: widget.mappedBankAccountsBean.bankName,accountNumber: Utils().getMaskedAccountNumber(widget.mappedBankAccountsBean.maskedAccountNumber),),
          ),
          otpIconWidget().paddingOnly(left: 35, right: 35),
          otpEntryWidget().paddingOnly(left: 35, right: 35),
          otpConfirmWidget().paddingOnly(left: 16, right: 16, top: 20),
        ],
      ),
    );
  }

  bool isFromAddedAccount() => widget.verificationType == VerificationType.ADD_ACCOUNT;
  Widget getBorderContainer() {
    return Container(
      height: 3,
      width: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: controller.errorMessage.value.isNotEmpty
                  ? Colors.pink
                  : isOtpEntered
                      ? Color(0xffb2f7e2)
                      : Color(0xffb0b4c1),
              width: 2.0,
              style: BorderStyle.solid),
        ),
        color: Colors.transparent,
      ),
    );
  }

  Widget otpConfirmWidget() {
    return Container(
      //margin: EdgeInsets.only(bottom: 16),
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: isOtpEntered ? Color(0xffb2f7e2) : Color(0xffe9ecef)),
      alignment: Alignment.center,
      child: Text(
        getTranslation(Strings.submit),
        textAlign: TextAlign.center,
        style: isOtpEntered
            ? BaseStyles.chatItemDepositSuccessMoneyTextStyle
            : BaseStyles.verifyTextStyle,
      ),
    ).onTap(onPressed: () {
      if (isOtpEntered) {
        if (widget.fetchOtpResponse.otpChallengeCode != null) {
          var toAddress = ToAddressResponse(
              mobileNumber: widget?.toAddress?.mobileNumber,
              customerProfile: widget.toAddress);
          if (isFromAddedAccount()) {
            controller.validateOtpAndTrackAddAccount(
                widget.txnId,
                widget.fetchOtpResponse,
                widget.retrieveKeyResponse,
                widget.deviceInfoBean,
                widget.bic);
            // pop();
          } else if (widget.verificationType == VerificationType.TRANSFER) {
            // controller.validateOtpAndTrack(widget.txnId,widget.fetchOtpResponse,widget.retrieveKeyResponse,widget.deviceInfoBean,widget.bic);
            controller.validateOtpAndTrackTransaction(
                widget.txnId,
                widget.fetchOtpResponse,
                widget.retrieveKeyResponse,
                widget.deviceInfoBean,
                widget.bic,
                TransactionContext.PAYMENT_REQUEST,
                widget.amount,
                toAddress,
                widget.verificationType,null);
            //pop();
          } else if (widget.verificationType ==VerificationType.BILL) {
            // controller.validateOtpAndTrack(widget.txnId,widget.fetchOtpResponse,widget.retrieveKeyResponse,widget.deviceInfoBean,widget.bic);
            controller.validateOtpAndTrackTransaction(
                widget.txnId,
                widget.fetchOtpResponse,
                widget.retrieveKeyResponse,
                widget.deviceInfoBean,
                widget.bic,
                TransactionContext.BILL_PAYMENT,
                widget.amount,
                 null,
                widget.verificationType,null);
            //pop();
          }else if (widget.verificationType == VerificationType.ORDER) {
            print(jsonEncode(toAddress.toJson()));
            // controller.validateOtpAndTrack(widget.txnId,widget.fetchOtpResponse,widget.retrieveKeyResponse,widget.deviceInfoBean,widget.bic);
            controller.validateOtpAndTrackTransaction(
                widget.txnId,
                widget.fetchOtpResponse,
                widget.retrieveKeyResponse,
                widget.deviceInfoBean,
                widget.bic,
                TransactionContext.BILL_PAYMENT,
                widget.amount,
                toAddress,
                widget.verificationType,
                widget.orderRequest);
            //pop();
          }
        }
      }
    });
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    controller.startTimer();
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false,
      // hides leading widget
      leading: IconButton(
          //  icon: Icon(Icons.arrow_back),
          icon: getSvgImage(
              imagePath: Assets.assets_icon_b_back_arrow,
              width: 24.0,
              height: 24.0),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
          ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.inputOTP),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  Widget otpIconWidget() {
    return Container(
      alignment: Alignment.center,
      child: getSvgImage(imagePath: Assets.group, width: 123.0, height: 135.0),
    );
  }

  Widget otpEntryWidget() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            margin: EdgeInsets.only(top: 1),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      style: TextStyles.verifyCodeTextStyle,
                      text:
                          getTranslation(Strings.mobile_verification_subtext) +
                              " "),
                  TextSpan(
                      style: TextStyles.otpRecieverMobileTextStyle,
                      text: controller.userMobileNumber.value ?? "")
                ]))),
        Container(
            padding: EdgeInsets.only(left: 24, right: 24),
            margin: EdgeInsets.only(top: 10),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      style: TextStyles.otpWithSMSTextStyle,
                      text:
                          "Enter the OTP code from the SMS with \nChallenge Code:\n"),
                  TextSpan(
                      style: TextStyles.challengeCodeTextStyle,
                      text: widget?.fetchOtpResponse?.otpChallengeCode ??
                          "000000")
                ]))),
        Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: OTPTextFieldWidget(
                width: MediaQuery.of(context).size.width,
                length: 6,
                fieldWidth: 40,
                textFieldAlignment: MainAxisAlignment.spaceBetween,
                fieldStyle: FieldStyle.underline,
                obscureText: false,
                style: BaseStyles.otpTextStyle,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  setState(() {
                    controller.otp.value = pin;
                    isOtpEntered = true;
                  });
                },
                onChanged: (pin) {
                  print("Completed: " + pin);
                  setState(() {
                    if (pin.trim().length < 6) {
                      controller.errorMessage.value = "";
                      isOtpEntered = false;
                    }
                  });
                },
              ),
            ),
            Container(
              height: 10,
              margin: EdgeInsets.only(
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getBorderContainer(),
                  getBorderContainer(),
                  getBorderContainer(),
                  getBorderContainer(),
                  getBorderContainer(),
                  getBorderContainer(),
                ],
              ),
            ),
          ],
        ),
        controller.errorMessage.value.isEmpty
            ? Container()
            : Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  getTranslation(controller.errorMessage.value),
                  style: BaseStyles.error_text_style,
                ),
              ),
        Container(
          margin: EdgeInsets.only(top: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6.5.toInt(),
                child: Container(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                      style: BaseStyles.sentOtpTextStyle,
                      text: getTranslation(Strings.sent_otp_text)),
                  TextSpan(
                      style: BaseStyles.sentOtpTimeTextStyle,
                      text: controller.countDownTimeString.value)
                ]))),
              ),
              Expanded(
                flex: 3.5.toInt(),
                child: Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Text(getTranslation(Strings.resend_otp),
                            style: (controller.countDownTimeString.value ==
                                        "00:00" &&
                                    controller.seconds.value == 0)
                                ? BaseStyles.bottomSheetLocationChangeTextStyle
                                : BaseStyles.resendDefaultTextStyle,
                            textAlign: TextAlign.center),
                        Container(
                          height: 2,
                          margin: EdgeInsets.only(top: 4, left: 8),
                          decoration: BoxDecoration(
                            gradient: Gradients.primaryGradient,
                          ),
                        ),
                      ],
                    )).onTap(onPressed: () async {
                  controller.refreshOtp(
                    widget.txnId,
                    widget.fetchOtpResponse,
                    widget.retrieveKeyResponse,
                    widget.deviceInfoBean,
                    widget.bic,
                    isFromAddedAccount()
                        ? ActionType.CARD_REGISTRATION
                        : ActionType.PURCHASE,
                    isFromAddedAccount()
                        ? TransactionType.REGISTER_CARD_ACC_DETAIL
                        : TransactionType.FINANCIAL_TXN,
                  );

                  /// todo
                  // if (controller.userMobileNumber.value.isNotEmpty && controller.countDownTimeString.value == "00:00") {
                  //   controller.startTimer();
                  //   ((widget.fetchOtpResponse.otpChallengeCode)!=null)?
                  //    controller.validateOtpAndTrack(widget.txnId,widget.fetchOtpResponse,widget.retrieveKeyResponse,widget.deviceInfoBean,widget.bic):
                  //    controller.getOtpForTransfer(isFromResendOtp:true);
                  // }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
