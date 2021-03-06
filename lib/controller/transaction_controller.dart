/*
*  transaction_controller.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/common/helpers/crypto_helper.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/controller/contacts_transfer_controller.dart';
import 'package:tara_app/controller/home_controller.dart';
import 'package:tara_app/data/session_local_data_source.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/registration_status.dart';
import 'package:tara_app/models/auth/to_address_response.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/mcpayment/create_card_or_pay_request.dart'
    as cards;
import 'package:tara_app/models/mcpayment/pay_card_request.dart';
import 'package:tara_app/models/order_management/orders/order_request.dart';
import 'package:tara_app/models/transactions/payment_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/models/transfer/account_details_request.dart';
import 'package:tara_app/models/transfer/add_beneficiary_request.dart';
import 'package:tara_app/models/transfer/authorize_request.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/models/transfer/confirm_account_registration_request.dart';
import 'package:tara_app/models/transfer/constants/action.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/constants/transaction_type.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/delete_account_request.dart';
import 'package:tara_app/models/transfer/device_info.dart';
import 'package:tara_app/models/transfer/fetch_otp_request.dart';
import 'package:tara_app/models/transfer/fetch_otp_response.dart';
import 'package:tara_app/models/transfer/payer_collect_request.dart';
import 'package:tara_app/models/transfer/payment_instrument.dart';
import 'package:tara_app/models/transfer/pre_transaction_request.dart';
import 'package:tara_app/models/transfer/refresh_otp_request.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_request.dart';
import 'package:tara_app/models/transfer/retrieve_key_response.dart';
import 'package:tara_app/models/transfer/track_account_details_response.dart';
import 'package:tara_app/models/transfer/track_transaction_request.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/models/transfer/transaction_request.dart';
import 'package:tara_app/models/transfer/validate_otp_request.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/mc_payment_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/common_webview.dart';
import 'package:tara_app/screens/consumer/my_account/otp_verification_screen.dart';
import 'package:tara_app/services/config/psp_config.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/utils/locale/utils.dart';

import '../injector.dart';
import '../tara_app.dart';
import 'package:async/async.dart';

import 'order_update_controller.dart';


enum TransactionContext { PAYMENT_REQUEST, BILL_PAYMENT }

class TransactionController extends GetxController {
  var showProgress = false.obs;
  var userMobileNumber = "".obs;
  var otp = "".obs;

  // var user = AuthResponse().obs;
  var errorMessage = "".obs;
  var countDownTimeString = "05:00".obs;

  Timer timer;
  var seconds = 300.obs;

  final AsyncMemoizer banksListMemorizer = AsyncMemoizer();


  TextEditingController txtCtrlTransferAmt = TextEditingController();
  double payAmount;
  String payTransId;
  ToAddressResponse toAddress;

  void sendMoney(CustomerProfile to, CustomerProfile from, double amount,
      [pop]) async {
    var fromData = FromDataBean(
        fromContactNumber: from.mobileNumber,
        fromUserFirebaseId: from.firebaseId);
    var toData = ToDataBean(
        toContactNumber: to.mobileNumber, toUserFirebaseId: to.firebaseId);
    var optionalDataBean = OptionalDataBean(
        data: DataBean(transactionContext: "Payment_Request", amount: amount));
    var transactionModel = TransactionModel(
      optionalData: optionalDataBean,
      fromData: fromData,
      toData: toData,
      paid: false,
      transactionType: "paid",
      subType: "Grocery",
      status: "INITIATED",
      transactionDate: DateTime.now().toIso8601String(),
    );
    showProgress.value = true;
    Either<Failure, PaymentResponse> responseDa = await getIt
        .get<TransactionRepository>()
        .initiateTaraTransaction(transactionModel);
    showProgress.value = false;
    responseDa.fold(
        (l) => print(l.message),
        (r) => {
              // pop,
              Get.to(ConversationPage(
                  showMakeAnOrder: false,
                  arrChats: ["chat_money_transfer_success"],
                  custInfo: Utils().getCustomerProfile())) //YAKUB Dummy Profile
            });
  }

  //payment initiation
  Future paymentInitiation(
      {TransactionContext trContext,
      String cardId,
      double amount,
      String desc,
      String maskAcNum,
      ToAddressResponse toAddress,
      bool isFromCreditCard = false,
      RequestType requestType = RequestType.PAY}) async {
    print("firebaseid " +
        Get.find<AuthController>().user.value.customerProfile.firebaseId);
    // print("to firebaseid "+ toAddress.customerProfile.firebaseId);
    payAmount = amount;
    var transactionContext =
        requestType == RequestType.PAY ? null : describeEnum(trContext);
    var fromData = FromDataBean(
        fromContactNumber:
            Get.find<AuthController>().user.value.customerProfile.mobileNumber,
        fromAccount: null,
        fromUserFirebaseId:
            Get.find<AuthController>().user.value.customerProfile.firebaseId);
    var toData = ToDataBean(
        toContactNumber: toAddress?.mobileNumber,
        toAccount: null,
        toUserFirebaseId: toAddress?.customerProfile?.firebaseId);
    var optionalDataBean = OptionalDataBean(
        data: DataBean(
            amount: amount,
            transactionContext: isFromCreditCard
                ? describeEnum(TransactionContext.BILL_PAYMENT)
                : transactionContext));
    var transactionModel = TransactionModel(
        optionalData: optionalDataBean,
        fromData: fromData,
        toData: toData,
        paid: false,
        transactionType: "paid",
        subType: "Grocery",
        status: "INITIATED",
        transactionDate: DateTime.now().toIso8601String(),
        toType: null);
    print(jsonEncode(transactionModel.toJson()));
    showProgress.value = true;
    Either<Failure, PaymentResponse> responseDa = await getIt
        .get<TransactionRepository>()
        .initiateTaraTransaction(transactionModel);
    // showProgress.value = false;

    responseDa.fold(
        (l) => print(l.message),
        (r) => {
              payTransId = r.transactionId,
              if (isFromCreditCard)
                {payViaCreditCard(cardId, amount, desc, maskAcNum)}
            });
  }

  // payment done
  Future<Either<Failure, BaseResponse>> paymentCompleted(
      {TransactionContext trContext,
      ToAddressResponse toAddress,
      num payAmount,PaymentStatus status = PaymentStatus.SUCCESS}) async {
    var fromData = FromDataBean(
        fromContactNumber:
            Get.find<AuthController>().user.value.customerProfile.mobileNumber,
        fromAccount: null,
        fromUserFirebaseId:
            Get.find<AuthController>().user.value.customerProfile.firebaseId);
    var toData = ToDataBean(
        toContactNumber: toAddress?.mobileNumber,
        toAccount: null,
        toUserFirebaseId: toAddress?.customerProfile?.firebaseId);

    var dataBean;
    if (trContext == TransactionContext.BILL_PAYMENT) {
      var productData = Get.find<BillController>().productDetail;
      dataBean = DataBean(
          transactionContext: describeEnum(trContext),
          createFirebaseEntry: "true",
          amount: payAmount,
          productCode: productData?.productCode,
          accountNumber: productData?.accountNumber,
          partnerId: PSPConfig.PARTNER_ID,
          buyerEmail:
              Get.find<AuthController>().user?.value?.customerProfile?.email,
          inquiryId: productData?.inquiryId,
          refNumber: productData?.refNumber,
          publicBuyerId: "123" //TODO
          );
    } else {
      dataBean = DataBean(
          transactionContext: describeEnum(trContext),
          createFirebaseEntry: "true",
          amount: payAmount);
    }

    var optionalDataBean = OptionalDataBean(data: dataBean);
    var transactionModel = TransactionModel(
        optionalData: optionalDataBean,
        transactionId: payTransId,
        fromData: fromData,
        toData: toData,
        paid: true,
        transactionType: "paid",
        subType: "Grocery",
        status: describeEnum(status),
        transactionDate: DateTime.now().toIso8601String(),
        toType: null);
    // showProgress.value = true;
    print(jsonEncode(transactionModel.toJson()));
    Either<Failure, BaseResponse> responseDa;
    if (payTransId != null) {
      responseDa = await getIt
          .get<TransactionRepository>()
          .updateTaraTransaction(transactionModel);
    } else {
      showProgress.value = false;
      return Left(Failure(message: "writing to realtime db failed"));
    }
    showProgress.value = false;
    return responseDa;
  }
  void getOtpForTransfer({bool isFromResendOtp = false}) async {
    //validate empty state here for the text fields

    showProgress.value = true;
    userMobileNumber.value =
        Get.find<AuthController>().user.value.customerProfile.mobileNumber;
    AuthRequest request = AuthRequest(mobileNumber: userMobileNumber.value);
    print(request.toJson());
    Either<Failure, BaseResponse> response = await getIt
        .get<AuthRepository>()
        .getOtp(AuthRequestWithData(data: request));
    showProgress.value = false;
    response.fold(
      (l) => print(l.message),
      (r) =>
          !isFromResendOtp ? Get.to(OTPVerificationScreen()) : print(r.message),
    );
  }

  void validateOtpForTransfer() async {
    //validate empty state here for the text fields
    if (isValidationSuccessInOtp()) {
      showProgress.value = true;
      userMobileNumber.value =
          Get.find<AuthController>().user.value.customerProfile.mobileNumber;
      AuthRequest request =
          AuthRequest(mobileNumber: userMobileNumber.value, otp: otp.value);
      Either<Failure, BaseResponse> response = await getIt
          .get<AuthRepository>()
          .validateOtp(AuthRequestWithData(data: request));
      showProgress.value = false;
      response.fold((l) => Get.defaultDialog(content: Text(l.message)), (r) {
        CustomerProfile fromUser =
            Get.find<AuthController>().user.value.customerProfile;
        sendMoney(Utils().getCustomerProfile(), fromUser,
            double.tryParse(txtCtrlTransferAmt.text) ?? 0.0);
      });
    }
  }

  bool isValidationSuccessInOtp() {
    if (GetUtils.isNullOrBlank(otp.value)) {
      errorMessage.value = Strings.enter_otp_code;
      return false;
    } else if (otp.value.length < 6) {
      errorMessage.value = Strings.invalid_otp;
      return false;
    } else {
      errorMessage.value = "";
    }
    return true;
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    if (timer != null) {
      timer.cancel();
      timer = null;
      seconds.value = 120;
    }

    timer = Timer.periodic(period, (timer) {
      // Update interface
      if (seconds.value == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      } else {
        seconds.value = seconds.value - 1;
        constructTime(seconds.value);
      }
    });
  }

  Future<CustomerProfileDetailsResponse> getCustomerProfile2() async {
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if (isSessionInitiated) {
      var commonRequest =
          await BaseRequestHelper().getCommonRegistrationRequest();

      var resp =
          await getIt.get<AuthRepository>().getCustomerProfile(commonRequest);
      return resp.getOrElse(() => null);
    }
  }

  Future getTransactions() async {
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if (isSessionInitiated) {
      var queries = await BaseRequestHelper().getCustomerDataQueryParam();

      var resp =
          await getIt.get<TransactionRepository>().getTxnHistory(queries);
      var transactionResp = resp.getOrElse(() => null);
      var transactionsListUpdated = <TransactionListBean>[];
      transactionResp.transactionList.forEach((element) {
        element.month = Jiffy.unix(element.timestamp).MMMM;
        transactionsListUpdated.add(element);
      });
      transactionResp.transactionList = transactionsListUpdated;
      return transactionResp;
    }
  }

  Future getBeneficiaries() async {
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if (isSessionInitiated) {
      var queries = await BaseRequestHelper().getCustomerDataQueryParam();

      var resp =
          await getIt.get<TransactionRepository>().getTxnHistory(queries);
      var transactionResp = resp.getOrElse(() => null);
      var transactionsListUpdated = <TransactionListBean>[];
      transactionResp.transactionList.forEach((element) {
        element.month = Jiffy.unix(element.timestamp).MMMM;
        transactionsListUpdated.add(element);
      });
      transactionResp.transactionList = transactionsListUpdated;
      return transactionResp;
    }
  }

  Future getBanksList() async {
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if (isSessionInitiated) {
      var commonRequest =
          await BaseRequestHelper().getCommonRegistrationRequest();
      var bankListR =
          await getIt.get<TransactionRepository>().getBanksList(commonRequest);
      if (bankListR.isRight()) {
        var response = bankListR.getOrElse(() => null);
        return response;
      }
    }
  }

  /// Delete Account API
  Future deleteBankAccount(
      MappedBankAccountsBean mappedBankAccountsBean) async {
    showProgress.value = true;
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    var commonRequest =
        await BaseRequestHelper().getCommonRegistrationRequest();
    if (isSessionInitiated) {
      var deleteAccountRequest = DeleteAccountRequest(
          custPSPId: commonRequest.custPSPId,
          accessToken: commonRequest.accessToken,
          accountTokenIds: [mappedBankAccountsBean.accountTokenId],
          requestedLocale: commonRequest.requestedLocale,
          acquiringSource: commonRequest.acquiringSource);

      print(jsonEncode(deleteAccountRequest.toJson()));
      var delAccInitResp = await getIt
          .get<TransactionRepository>()
          .initiateDeleteAccountRequest(deleteAccountRequest);
      await delAccInitResp.fold(
          (l) =>
              {showProgress.value = false, showDialogWithErrorMsg(l.message)},
          (r) => trackAccountDeletion(r));
    }
  }

  ///Track Account Deletion API
  void trackAccountDeletion(TrackAccountDetailsResponse r) async {
    try {
      var req = await BaseRequestHelper().getCommonRegistrationRequest();
      req.transactionId = r.transactionId;
      var resp = await getIt
          .get<TransactionRepository>()
          .trackDeleteAccountDetailsRequest(req);
      showProgress.value = false;
      await resp.fold(
          (l) =>
              {showProgress.value = false, showDialogWithErrorMsg(l.message)},
          (r) => {
                showProgress.value = false,
                Get.back(),
              });
    } catch (e) {
      showProgress.value = false;
      showDialogWithErrorMsg("internal error");
    }
  }

  Future addBankAccount(
      String bicValue,
      String last6Digits,
      String name,
      String cardNumber,
      String cvvData,
      String expM,
      String expY,
      String accountNum) async {
    showProgress.value = true;
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    var commonRequest =
        await BaseRequestHelper().getCommonRegistrationRequest();
    if (isSessionInitiated) {
      var bic = bicValue; //"CENAID00001";
      var accountDetailsRequest = AccountDetailsRequest(
          custPSPId: commonRequest.custPSPId,
          accessToken: commonRequest.accessToken,
          bic: bic,
          // transactionId: commonRequest.transactionId,
          requestedLocale: commonRequest.requestedLocale,
          cardLast6Digits: last6Digits, //"012345",
          acquiringSource: commonRequest.acquiringSource);
      print(jsonEncode(accountDetailsRequest.toJson()));
      var accInitResp = await getIt
          .get<TransactionRepository>()
          .initiateAccountDetailsRequest(accountDetailsRequest);
      var startTime = DateTime.now().microsecondsSinceEpoch;
      if (accInitResp.isRight()) {
        var accInitiateResponse = accInitResp.getOrElse(() => null);
        var txnId = accInitiateResponse.transactionId;
        if (accInitiateResponse.success) {
          var deviceInfo = await BaseRequestHelper().getDeviceInfoBeanWithPSP();
          var retrieveKeyRequest = RetrieveKeyRequest(
              deviceInfo: deviceInfo,
              paymentInstrument: PaymentInstrumentBean(
                  paymentInstrumentType: "ACCOUNT", bic: bic),
              resetCredentialCall: false,
              startDateTime: startTime);
          print(jsonEncode(retrieveKeyRequest.toJson()));
          var respo = await getIt.get<TransactionRepository>().retrieveKey(
              retrieveKeyRequest,
              TransactionType.REGISTER_CARD_ACC_DETAIL,
              accInitiateResponse.transactionId);
          if (respo.isRight()) {
            var retriveKeyResponse = respo.getOrElse(() => null);
            print(jsonEncode(retriveKeyResponse.toJson()));
            var fullName = await CryptoHelper().encryptBankData(
                "$txnId|$name|${Random.secure()}",
                retriveKeyResponse.bankKi,
                retriveKeyResponse.publicKey);
            //Card Number  == 16 digit Number
            var number = await CryptoHelper().encryptBankData(
                "$txnId|$cardNumber|${Random.secure()}",
                retriveKeyResponse.bankKi,
                retriveKeyResponse.publicKey);
            //CVV == 123
            var cvv = await CryptoHelper().encryptBankData(
                "$txnId|$cvvData|${Random.secure()}",
                retriveKeyResponse.bankKi,
                retriveKeyResponse.publicKey);
            //exp Month == 02
            var expMM = await CryptoHelper().encryptBankData(
                "$txnId|$expM|${Random.secure()}",
                retriveKeyResponse.bankKi,
                retriveKeyResponse.publicKey);
            //exp Year == 25
            var expYY = await CryptoHelper().encryptBankData(
                "$txnId|$expY|${Random.secure()}",
                retriveKeyResponse.bankKi,
                retriveKeyResponse.publicKey);
            //1010101010101010 ==> Account Number
            var accountNumber = await CryptoHelper().encryptBankData(
                "$txnId|$accountNum|${Random.secure()}",
                retriveKeyResponse.bankKi,
                retriveKeyResponse.publicKey);
            var registerRequest = RegisterCardRequest(
                card: CardBean(
                    cvv: cvv,
                    number: number,
                    expiryMonth: expMM,
                    expiryYear: expYY,
                    fullName: fullName),
                bic: bic,
                startDateTime: startTime,
                deviceInfo: deviceInfo,
                accountInfo: AccountInfoBean(
                  bic: bic,
                  accountNo: accountNumber,
                ));
            print(jsonEncode(registerRequest.toJson()));
            var resp = await getIt
                .get<TransactionRepository>()
                .registerCardDetail(
                    registerRequest,
                    retriveKeyResponse.sessionKey,
                    txnId,
                    retriveKeyResponse.publicKey);
            if (resp.isRight()) {
              var registerCardResponse = resp.getOrElse(() => null);
              print(jsonEncode(registerCardResponse.toJson()));
              var confirmAccountRegistrationRequest =
                  ConfirmAccountRegistrationRequest(
                      bic: bic, accepted: true, deviceInfo: deviceInfo);
              print(jsonEncode(confirmAccountRegistrationRequest.toJson()));
              var confirmResp = await getIt
                  .get<TransactionRepository>()
                  .confirmAccountRegistration(confirmAccountRegistrationRequest,
                      retriveKeyResponse.sessionKey, txnId);
              if (confirmResp.isRight()) {
                var res = confirmResp.getOrElse(() => null);
                if (res.commonResponse.success) {
                  var fetchOtpRequest = FetchOtpRequest(
                    deviceInfo: deviceInfo,
                    paymentInstrument: PaymentInstrumentBean(
                        bic: bic, paymentInstrumentType: "ACCOUNT"),
                    action: ActionType.CARD_REGISTRATION,
                  );
                  print(jsonEncode(fetchOtpRequest.toJson()));
                  Timer(Duration(seconds: 2), () async {
                    var fetchOTPR = await getIt
                        .get<TransactionRepository>()
                        .fetchOtp(
                            fetchOtpRequest,
                            TransactionType.REGISTER_CARD_ACC_DETAIL,
                            retriveKeyResponse.sessionKey,
                            txnId);
                    if (fetchOTPR.isRight()) {
                      var fetchOTPResponse = fetchOTPR.getOrElse(() => null);
                      print(jsonEncode(fetchOTPResponse.toJson()));
                      userMobileNumber.value = Get.find<AuthController>()
                          .user
                          .value
                          .customerProfile
                          .mobileNumber;
                      showProgress.value = false;
                      var maskedNumber = "***********3333#************" +
                          cardNumber.substring(
                              cardNumber.length - 4, cardNumber.length);
                      Get.to(OTPVerificationScreen(
                        txnId: txnId,
                        fetchOtpResponse: fetchOTPResponse,
                        retrieveKeyResponse: retriveKeyResponse,
                        deviceInfoBean: deviceInfo,
                        bic: bic,
                        selectedSourceBankAccount: MappedBankAccountsBean(
                            maskedAccountNumber: maskedNumber),
                        verificationType: VerificationType.ADD_ACCOUNT,
                      ));

                      //  Get.to(OTPVerificationScreen(txnId,fetchOTPResponse,retriveKeyResponse,deviceInfo,bic));
                      // call in OTP validation Screen
                      //await validateOtpAndTrack(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                    } else {
                      showProgress.value = false;
                      showDialogWithErrorMsg("Unable to to send the OTP");
                    }
                  });
                }
              }
            }
          }
        }
      }
    }
  }

  void refreshOtp(
      String txnId,
      FetchOtpResponse fetchOTPResponse,
      RetrieveKeyResponse d,
      DeviceInfoBean deviceInfo,
      String bic,
      ActionType actionType,
      TransactionType transactionType) {
    var refreshOtpRequest = RefreshOtpRequest(
        deviceInfo: deviceInfo,
        bic: bic,
        action: actionType,
        referenceId: fetchOTPResponse.referenceId);
    print(jsonEncode(refreshOtpRequest.toJson()));
    Timer(Duration(seconds: 2), () async {
      var response = await getIt
          .get<TransactionRepository>()
          .refreshOtp(refreshOtpRequest, transactionType, d.sessionKey, txnId);

      response.fold((l) => showDialogWithErrorMsg(l.message),
          (r) => showDialogWithErrorMsg("Otp sent successfully"));
    });
  }

  Future validateOtpAndTrackAddAccount(
      String txnId,
      FetchOtpResponse fetchOTPResponse,
      RetrieveKeyResponse d,
      DeviceInfoBean deviceInfo,
      String bic) async {
    showProgress.value = true;
    print("OTP SENDING IN REQ:=>" + otp.value.toString());
    var encValid = await CryptoHelper().encryptBankData(
        "$txnId|${otp.value}|${Random.secure()}", d.bankKi, d.publicKey);
    var validateOtpRequest = ValidateOtpRequest(
        deviceInfo: deviceInfo,
        bic: bic,
        action: ActionType.CARD_REGISTRATION,
        referenceId: fetchOTPResponse.referenceId,
        otp: encValid);
    print(jsonEncode(validateOtpRequest.toJson()));
    var validateOTPR = await getIt.get<TransactionRepository>().validateOtp(
        validateOtpRequest,
        TransactionType.REGISTER_CARD_ACC_DETAIL,
        d.sessionKey,
        txnId);
    if (validateOTPR.isRight()) {
      var validateOTPResponse = validateOTPR.getOrElse(() => null);

      if (validateOTPResponse?.commonResponse?.success ?? false) {
        print(jsonEncode(validateOTPResponse.toJson()));
        var req = await BaseRequestHelper().getCommonRegistrationRequest();
        req.transactionId = txnId;
        print(jsonEncode(req.toJson()));
        var trackAccountR = await getIt
            .get<TransactionRepository>()
            .trackAccountDetailsRequest(req,
                TransactionType.REGISTER_CARD_ACC_DETAIL, d.sessionKey, txnId);
        if (trackAccountR.isRight()) {
          var trackAccountResponse = trackAccountR.getOrElse(() => null);

          showProgress.value = false;
          print(jsonEncode(trackAccountResponse.toJson()));
          await Get.find<HomeController>().getMyAccounts();
          Get.offAll(Utils().getLandingScreen());
        }else {
          showProgress.value = false;
          showDialogWithErrorMsg("Falied to track the transaction");
        }
      } else {
        showProgress.value = false;
        showDialogWithErrorMsg("Invalid OTP");
      }
    }else {
      showProgress.value = false;
      showDialogWithErrorMsg("OTP validation Unknown Error");
    }
  }

  Future payBill(
      {String subMerchantName,
      String merchantRef,
      String amount1= "100",
      String remarks1,
      String bic1,
      String cvv1,
      num initiatorAccountId,
      MappedBankAccountsBean selectedSourceBankAccount,
        CustomerProfile merchantProfile,
        OrderRequest orderRequest}) async {
    var customerProfile = await getCustomerProfile2();
    var deviceRegInfo =
        await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
    var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
    var custRefId = "${DateTime.now().millisecondsSinceEpoch}";
    var remarks = remarks1;
    var merchantTxnId = uuid
        .v1(); //need to keep this transaction ID alive for track the transaction request.
    var bic =
        bic1; //bic1; // get these from Search beneficiary call by passing the mobile number to the api
    var cvvValue = cvv1;

    var merchantId = PSPConfig.MERCHANT_ID;

    // if(orderRequest!=null){
    //   merchantId = orderRequest.merchantId.toString();
    // }
    //do merchant transaction
    var isMerchantSessionInitiated = await getIt
        .get<DeviceRegisterRepository>()
        .getAppTokenMerchant(
            CommonRegistrationRequest(merchantId: merchantId));

    if (isMerchantSessionInitiated.isRight()) {
      var merchantLoginResponse =
          isMerchantSessionInitiated.getOrElse(() => null);
      print("============ MERCHANT LOGIN TOKEN RESPONSE======");
      print(jsonEncode(merchantLoginResponse.toJson()));
      if (merchantLoginResponse?.token?.isNotEmpty ?? false) {
        var payeeInfo = PayeesBean(
          amount: amount1,
          mobileNo: merchantProfile.mobileNumber // Added for SHOP Payment
        );
        var payerInfo = PayeesBean(
            mobileNo: customerProfile.mobileNo, appId: PSPConfig.APP_NAME);
        var transactionRequest = TransactionRequest(
            type: RequestType.COLLECT,
            requestedLocale: "en",
            accessToken: merchantLoginResponse.token,
            payees: [payeeInfo],
            payer: payerInfo,
            merchantId: merchantId, //CHANGED FOR SHOP PAYMENTS
            subMerchantName: subMerchantName,
            custRefId: custRefId,
            remarks: remarks);
        print(
            "=====================Merchant Transaction Request======================");
        print(jsonEncode(transactionRequest.toJson()));
        var tResp = await getIt
            .get<TransactionRepository>()
            .initiateMerchantTransactionRequest(transactionRequest);
        if (tResp.isRight()) {
          var merchantTxnResponse = tResp.getOrElse(() => null);
          print(
              "=====================Merchant Transaction Response======================");
          print(jsonEncode(merchantTxnResponse.toJson()));
          if (merchantTxnResponse.success) {
            showProgress.value = true;
            var isSessionInitiated = await getIt
                .get<DeviceRegisterRepository>()
                .checkAndInitiateSession();
            if (isSessionInitiated) {
              if(merchantProfile!=null){
                toAddress = ToAddressResponse(mobileNumber: merchantProfile.mobileNumber,customerProfile: merchantProfile);
              }
              await paymentInitiation(
                  amount: double.parse(amount1),
                  toAddress: toAddress,
                  trContext: TransactionContext.BILL_PAYMENT);
              //Retrieve Key Request
              merchantTxnId = merchantTxnResponse.transactionId;

              var payerCollectRequest = PayerCollectRequest(
                  acquiringSource:
                      await BaseRequestHelper().getCommonAcquiringSourceBean(),
                  requestedLocale: "en",
                  accessToken: tokenResponse.token,
                  custPSPId: deviceRegInfo.pspIdentifier,
                  approved: true,
                  approvedAmount: amount1,
                  accountTokenId: initiatorAccountId,
                  merchantTxnId: merchantTxnId);
              print(jsonEncode(payerCollectRequest.toJson()));
              var payerCollectR = await getIt
                  .get<TransactionRepository>()
                  .payerCollectResponse(payerCollectRequest);
              if (payerCollectR.isRight()) {
                var payerCollectResponse = payerCollectR.getOrElse(() => null);
                if (payerCollectResponse.success) {
                  print(jsonEncode(payerCollectResponse.toJson()));
                  var txnId = payerCollectResponse
                      .transactionId; // transaction id comees in the collect resposne call
                  var deviceInfo =
                      await BaseRequestHelper().getDeviceInfoBeanWithPSP();
                  var retrieveKeyRequest = RetrieveKeyRequest(
                      deviceInfo: deviceInfo,
                      paymentInstrument: PaymentInstrumentBean(
                          paymentInstrumentType: "ACCOUNT", bic: bic),
                      resetCredentialCall: false,
                      startDateTime: DateTime.now().microsecondsSinceEpoch);
                  print(
                      "=====================Transaction Resposne======================");
                  print(jsonEncode(retrieveKeyRequest.toJson()));
                  var respo = await getIt
                      .get<TransactionRepository>()
                      .retrieveKey(retrieveKeyRequest,
                          TransactionType.FINANCIAL_TXN, txnId);
                  if (respo.isRight()) {
                    var retriveKeyResponse = respo.getOrElse(() => null);
                    print(jsonEncode(retriveKeyResponse.toJson()));
                    var cvv = await CryptoHelper().encryptBankData(
                        "$txnId|$cvvValue|${Random.secure()}",
                        retriveKeyResponse.bankKi,
                        retriveKeyResponse.publicKey);
                    var authorizeReq = AuthorizeRequest(
                        deviceInfo: await BaseRequestHelper()
                            .getDeviceInfoBeanWithPSP(),
                        authorizePINCred: AuthorizePINCredBean(
                            credType: "MPIN", credValue: cvv));
                    var respo2 = await getIt
                        .get<TransactionRepository>()
                        .authorize(authorizeReq, TransactionType.FINANCIAL_TXN,
                            retriveKeyResponse.sessionKey, txnId);
                    if (respo2.isRight()) {
                      var res = respo2.getOrElse(() => null);
                      if (res.commonResponse.success) {
                        var fetchOtpRequest = FetchOtpRequest(
                          deviceInfo: deviceInfo,
                          paymentInstrument: PaymentInstrumentBean(
                              bic: bic, paymentInstrumentType: "ACCOUNT"),
                          action: ActionType.PURCHASE,
                        );
                        print(jsonEncode(fetchOtpRequest.toJson()));
                        Timer(Duration(seconds: 2), () async {
                          var deviceRegInfo = await getIt
                              .get<SessionLocalDataStore>()
                              .getDeviceRegInfo();
                          if (deviceRegInfo != null) {
                            print(jsonEncode(deviceRegInfo.toJson()));
                            var fetchOTPR = await getIt
                                .get<TransactionRepository>()
                                .fetchOtp(
                                    fetchOtpRequest,
                                    TransactionType.FINANCIAL_TXN,
                                    retriveKeyResponse.sessionKey,
                                    txnId);
                            if (fetchOTPR.isRight()) {
                              var fetchOTPResponse =
                                  fetchOTPR.getOrElse(() => null);
                              print(jsonEncode(fetchOTPResponse.toJson()));
                              userMobileNumber.value =
                                  Get.find<AuthController>()
                                      .user
                                      .value
                                      .customerProfile
                                      .mobileNumber;
                              showProgress.value = false;
                              Get.to(OTPVerificationScreen(
                                txnId: txnId,
                                fetchOtpResponse: fetchOTPResponse,
                                retrieveKeyResponse: retriveKeyResponse,
                                deviceInfoBean: deviceInfo,
                                bic: bic,
                                verificationType: orderRequest!=null?VerificationType.ORDER:VerificationType.BILL,
                                amount: double.parse(amount1),
                                selectedSourceBankAccount:
                                    selectedSourceBankAccount,
                                toAddress: merchantProfile,
                                orderRequest: orderRequest,
                              ));

                              //Break the Flow here and take him to the OTP Enter Screen  // take the otp from fetchOTPResponse in the next screen
                              // var re = await validateOtpAndTrackTransaction(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                            } else {
                              showDialogWithErrorMsg("Unable to fetch the otp");
                            }
                          } else {
                            showDialogWithErrorMsg(
                                "Failed to get Device Reg Info");
                          }
                        });
                      } else {
                        showDialogWithErrorMsg("Authroziation Failed");
                      }
                    } else {
                      showDialogWithErrorMsg("Authorization Response Failed");
                    }
                  } else {
                    showDialogWithErrorMsg("Retrieve key request failed");
                  }
                } else {
                  showDialogWithErrorMsg("Payer Collect Response Failed");
                }
              } else {
                showDialogWithErrorMsg("Payer Collect Response Failed");
              }
            } else {
              showDialogWithErrorMsg("Session not initiated ");
            }
          } else {
            showDialogWithErrorMsg("Merchant Transaction initiation failed");
          }
        }
      }
    }
  }

  Future payNow(
      {String mobileNumber,
      String amount1,
      String remarks1,
      String bic1,
      String cvv1,
      num initiatorAccountId1,
      num benId1,
      num selfAccountTokenId,
      MappedBankAccountsBean selectedSourceBankAccount}) async {
    showProgress.value = true;
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if (isSessionInitiated) {
      //  var toMobileNumber = "8368951368";//"8106170677";//"9295909790";  should be without country code
      var toMobileNumber = mobileNumber.removeAllWhitespace;
      var amount = amount1;
      var remarks = remarks1;
      var merchantTxnId = uuid
          .v1(); //need to keep this transaction ID alive for track the transaction request.
      var benId =
          benId1; // get these from Search beneficiary call by passing the mobile number to the api
      var bic =
          bic1; //bic1; // get these from Search beneficiary call by passing the mobile number to the api
      var cvvValue = cvv1;
// These below two lines has to be removed
      var customerProfile = await getCustomerProfile2();
      //  var initiatorAccountId = customerProfile.mappedBankAccounts[0].accountTokenId;
      var initiatorAccountId = initiatorAccountId1;

      var commonRequest =
          await BaseRequestHelper().getCommonRegistrationRequest();
      var deviceRegInfo =
          await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var sessionInfo =
          await getIt.get<SessionLocalDataStore>().getSessionInfo();
      print("=====================ffffffffffffffffff======================");

      var preTransactionRequest = PreTransactionRequest(
        type: RequestType.PAY,
        acquiringSource:
            await BaseRequestHelper().getCommonAcquiringSourceBean(),
        requestedLocale: "en",
        accessToken: tokenResponse.token,
        custPSPId: deviceRegInfo.pspIdentifier,
        amount: amount,
      );
      print(jsonEncode(preTransactionRequest.toJson()));

      var resp = await getIt
          .get<TransactionRepository>()
          .initiatePreTransactionRequest(preTransactionRequest);
      if (resp.isRight()) {
        var preTransactionResponse = resp.getOrElse(() => null);
        print(
            "=====================Pre Transaction Request======================");
        print(jsonEncode(preTransactionResponse.toJson()));
        if (preTransactionResponse.success) {
          var payeeInfo = PayeesBean(
              amount: amount,
              appId: PSPConfig.APP_NAME,
              mobileNo: toMobileNumber,
              beneId: benId,
              targetSelfAccountTokenId: selfAccountTokenId);
          var transactionRequest = TransactionRequest(
            type: RequestType.PAY,
            acquiringSource:
                await BaseRequestHelper().getCommonAcquiringSourceBean(),
            requestedLocale: "en",
            accessToken: tokenResponse.token,
            custPSPId: deviceRegInfo.pspIdentifier,
            remarks: remarks,
            payees: [payeeInfo],
            merchantTxnId: merchantTxnId,
            feeTaxRefId: preTransactionResponse.feeTaxRefId,
            initiatorAccountId: initiatorAccountId, //TODO CHANGE
          );
          print(
              "=====================Transaction Request======================");
          print(jsonEncode(transactionRequest.toJson()));
          var tResp = await getIt
              .get<TransactionRepository>()
              .initiateTransactionRequest(transactionRequest);
          if (tResp.isRight()) {
            var initiateTransactionResponse = tResp.getOrElse(() => null);
            print(
                "=====================Transaction Resposne======================");
            print(jsonEncode(initiateTransactionResponse.toJson()));
            var toAddress ;//= await getCustomerInfo(toMobileNumber);
            if (initiateTransactionResponse.success) {
              if(selfAccountTokenId!=0){
                var custProfile = Get.find<AuthController>().user.value.customerProfile;
                toAddress = ToAddressResponse( mobileNumber: custProfile?.mobileNumber,customerProfile: custProfile);
              }else{
                toAddress = await getCustomerInfo(toMobileNumber);
              }

              if (toAddress != null) {
                await paymentInitiation(
                    amount: double.parse(amount1),
                    toAddress: toAddress,
                    trContext: TransactionContext.PAYMENT_REQUEST);
                //Retrieve Key Request
                var txnId = initiateTransactionResponse.transactionId;
                var deviceInfo =
                    await BaseRequestHelper().getDeviceInfoBeanWithPSP();
                var retrieveKeyRequest = RetrieveKeyRequest(
                    deviceInfo: deviceInfo,
                    paymentInstrument: PaymentInstrumentBean(
                        paymentInstrumentType: "ACCOUNT", bic: bic),
                    resetCredentialCall: false,
                    startDateTime: DateTime.now().microsecondsSinceEpoch);
                print(
                    "=====================Transaction Resposne======================");
                print(jsonEncode(retrieveKeyRequest.toJson()));
                var respo = await getIt
                    .get<TransactionRepository>()
                    .retrieveKey(retrieveKeyRequest,
                        TransactionType.FINANCIAL_TXN, txnId);
                if (respo.isRight()) {
                  var retriveKeyResponse = respo.getOrElse(() => null);
                  print(jsonEncode(retriveKeyResponse.toJson()));
                  var cvv = await CryptoHelper().encryptBankData(
                      "$txnId|$cvvValue|${Random.secure()}",
                      retriveKeyResponse.bankKi,
                      retriveKeyResponse.publicKey);
                  var authorizeReq = AuthorizeRequest(
                      deviceInfo:
                          await BaseRequestHelper().getDeviceInfoBeanWithPSP(),
                      authorizePINCred: AuthorizePINCredBean(
                          credType: "MPIN", credValue: cvv));
                  var respo2 = await getIt
                      .get<TransactionRepository>()
                      .authorize(authorizeReq, TransactionType.FINANCIAL_TXN,
                          retriveKeyResponse.sessionKey, txnId);
                  if (respo2.isRight()) {
                    var res = respo2.getOrElse(() => null);
                    if (res.commonResponse.success) {
                      var fetchOtpRequest = FetchOtpRequest(
                        deviceInfo: deviceInfo,
                        paymentInstrument: PaymentInstrumentBean(
                            bic: bic, paymentInstrumentType: "ACCOUNT"),
                        action: ActionType.PURCHASE,
                      );
                      print(jsonEncode(fetchOtpRequest.toJson()));
                      Timer(Duration(seconds: 2), () async {
                        var deviceRegInfo = await getIt
                            .get<SessionLocalDataStore>()
                            .getDeviceRegInfo();
                        if (deviceRegInfo != null) {
                          print(jsonEncode(deviceRegInfo.toJson()));
                          var fetchOTPR = await getIt
                              .get<TransactionRepository>()
                              .fetchOtp(
                                  fetchOtpRequest,
                                  TransactionType.FINANCIAL_TXN,
                                  retriveKeyResponse.sessionKey,
                                  txnId);
                          if (fetchOTPR.isRight()) {
                            var fetchOTPResponse =
                                fetchOTPR.getOrElse(() => null);
                            print(jsonEncode(fetchOTPResponse.toJson()));
                            userMobileNumber.value = Get.find<AuthController>()
                                .user
                                .value
                                .customerProfile
                                .mobileNumber;
                            showProgress.value = false;
                            Get.to(OTPVerificationScreen(
                                txnId: txnId,
                                fetchOtpResponse: fetchOTPResponse,
                                retrieveKeyResponse: retriveKeyResponse,
                                deviceInfoBean: deviceInfo,
                                bic: bic,
                                verificationType: VerificationType.TRANSFER,
                                toAddress: toAddress.customerProfile,
                                selectedSourceBankAccount:
                                    selectedSourceBankAccount));

                            //Break the Flow here and take him to the OTP Enter Screen  // take the otp from fetchOTPResponse in the next screen
                            // var re = await validateOtpAndTrackTransaction(txnId, fetchOTPResponse, retriveKeyResponse, deviceInfo, bic);
                          } else {
                            showDialogWithErrorMsg("Unable to fetch the otp");
                          }
                        } else {
                          showDialogWithErrorMsg(
                              "Failed to get Device Reg Info");
                        }
                      });
                    } else {
                      showDialogWithErrorMsg("Authroziation Failed");
                    }
                  } else {
                    showDialogWithErrorMsg("Authorization Response Failed");
                  }
                } else {
                  showDialogWithErrorMsg("Retrieve key request failed");
                }
              } else {
                showDialogWithErrorMsg("Entered invalid mobile number");
              }
            } else {
              showDialogWithErrorMsg(" init transaction initiation Failed");
            }
          } else {
            showDialogWithErrorMsg(" init transaction Request Failed");
          }
        } else {
          showDialogWithErrorMsg("Pretransaction not initiated");
        }
      } else {
        showDialogWithErrorMsg("Pretransaction Request Failed");
      }
    } else {
      showDialogWithErrorMsg("Session not initiated ");
    }
  }

  Future<ToAddressResponse> getCustomerInfo(toMobileNumber) async {
    var toAddressResp = await Get.find<AuthController>().getToAddressForPayment(
        toMobileNumber.substring(1, toMobileNumber.length));
    if (toAddressResp.isRight()) {
      var toAddress = toAddressResp.getOrElse(() => null);
      return toAddress;
    } else {
      var customerProfileResponse = await Get.find<AuthController>()
          .getNonTaraCustomerInfo(
              toMobileNumber.substring(1, toMobileNumber.length));
      if (customerProfileResponse.isRight()) {
        var data = customerProfileResponse.getOrElse(() => null);
        return ToAddressResponse(
            mobileNumber: data.mobileNumber, customerProfile: data);
      }
    }
    return Future.value(null);
  }

  Future validateOtpAndTrackTransaction(
      String txnId,
      FetchOtpResponse fetchOTPResponse,
      RetrieveKeyResponse d,
      var deviceInfo,
      String bic,
      TransactionContext transactionContext,
      num amount,
      ToAddressResponse toAddress,
      VerificationType verificationType,OrderRequest orderRequest) async {
    showProgress.value = true;
    var encValid = await CryptoHelper().encryptBankData(
        "$txnId|${otp.value}|${Random.secure()}", d.bankKi, d.publicKey);
    var validateOtpRequest = ValidateOtpRequest(
        deviceInfo: deviceInfo,
        bic: bic,
        action: ActionType.PURCHASE,
        referenceId: fetchOTPResponse.referenceId,
        otp: encValid);
    print(jsonEncode(validateOtpRequest.toJson()));
    var validateOTPR = await getIt.get<TransactionRepository>().validateOtp(
        validateOtpRequest, TransactionType.FINANCIAL_TXN, d.sessionKey, txnId);
    if (validateOTPR.isRight()) {
      var validateOTPResponse = validateOTPR.getOrElse(() => null);
      print(jsonEncode(validateOTPResponse.toJson()));

      var req = await BaseRequestHelper().getCommonRegistrationRequest();
      req.transactionId = txnId;
      print(jsonEncode(req.toJson()));
      var deviceRegInfo =
          await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var rr = TrackTransactionRequest(
          acquiringSource:
              await BaseRequestHelper().getCommonAcquiringSourceBean(),
          requestedLocale: "en",
          accessToken: tokenResponse.token,
          transactionId: txnId,
          custPSPId: deviceRegInfo.pspIdentifier,
          waitForCompletion: true);

      var trackAccountR =
          await getIt.get<TransactionRepository>().trackTransactionRequest(rr);
      if (trackAccountR.isRight()) {
        var trackAccountResponse = trackAccountR.getOrElse(() => null);
        print(jsonEncode(trackAccountResponse.toJson()));
        if (trackAccountResponse.success) {
          if(verificationType == VerificationType.ORDER){
              Get.put(TransactionController());
              Get.find<HomeController>().getTransactionsHistory();

              var response = await Get.find<OrderUpdateController>().updateOrder(orderRequest);
              showProgress.value = false;
              print("Order Status PAID and Updated");
              Get.back();
              Get.back();
              // Get.to(ConversationPage(
              //     entry: entry,
              //     selectedContact: ContactInfo(),
              //     custInfo: toAddress.customerProfile));

          }else{
            var response = await paymentCompleted(
                toAddress: toAddress,
                trContext: transactionContext,
                payAmount: payAmount);
            if (response.isRight()) {
              var paymentCompleteRes = trackAccountR.getOrElse(() => null);
              if (paymentCompleteRes != null) {
                var entry;
                // if (transactionContext == TransactionContext.PAYMENT_REQUEST) {
                if (verificationType == VerificationType.TRANSFER) {
                  entry = ChatEntryPoint.TRANSFER;
                  Get.find<HomeController>().getTransactionsHistory();
                  Get.to(ConversationPage(
                    entry: entry,
                    selectedContact: ContactInfo(),
                    custInfo: toAddress?.customerProfile,
                  ));
                  Get.put(TransactionController());
                }
                // else if (transactionContext == TransactionContext.BILL_PAYMENT) {
                else if (verificationType == VerificationType.BILL) {
                  entry = ChatEntryPoint.MC_PAYMENT;
                  var custInfo = CustomerProfile(
                      firebaseId: "BillPayment", firstName: "Bill Payment");
                  Get.put(TransactionController());
                  Get.find<HomeController>().getTransactionsHistory();
                  showProgress.value = false;
                  Get.to(ConversationPage(
                      entry: entry,
                      selectedContact: ContactInfo(),
                      custInfo: custInfo));
                }else if (verificationType == VerificationType.ORDER) {
                  entry = ChatEntryPoint.ORDER;
                  Get.put(TransactionController());
                  Get.find<HomeController>().getTransactionsHistory();

                  var response = await Get.find<OrderUpdateController>().updateOrder(orderRequest);
                  showProgress.value = false;
                  print("Order Status PAID and Updated");
                  Get.back();
                  Get.back();
                  // Get.to(ConversationPage(
                  //     entry: entry,
                  //     selectedContact: ContactInfo(),
                  //     custInfo: toAddress.customerProfile));
                }
              }
            } else {
              navigateToChat(transactionContext);
              print("transaction failed");
            }
          }


        } else {
          showDialogWithErrorMsg("Transaction Verification failed");
        }
      } else {
        showProgress.value = false; // TODO need to remove
        // show dailog here
      }
    }
  }

  navigateToChat(transactionContext) {
    var entry;
    if (transactionContext == TransactionContext.PAYMENT_REQUEST) {
      entry = ChatEntryPoint.TRANSFER;
      Get.put(TransactionController());
      Get.to(ConversationPage(
        entry: entry,
        selectedContact: ContactInfo(),
        custInfo: toAddress?.customerProfile,
      ));
    } else if (transactionContext == TransactionContext.BILL_PAYMENT) {
      entry = ChatEntryPoint.MC_PAYMENT;
      var custInfo =
          CustomerProfile(firebaseId: "BillPayment", firstName: "Bill Payment");
      Get.put(TransactionController());
      showProgress.value = false;
      Get.to(ConversationPage(
          entry: entry, selectedContact: ContactInfo(), custInfo: custInfo));
    }
  }

  Future addBeneficiary(
      {String mobile,
      String accountNo,
      String bic,
      String name,
      String accountType = "SAVINGS",
      bool isNewUser = false}) async {
    showProgress.value = true;
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();

    if (isSessionInitiated) {
      var deviceRegInfo =
          await getIt.get<SessionLocalDataStore>().getDeviceRegInfo();
      var tokenResponse = await getIt.get<SessionLocalDataStore>().getToken();
      var addBeneficiaryRequest = AddBeneficiaryRequest(
          acquiringSource:
              await BaseRequestHelper().getCommonAcquiringSourceBean(),
          requestedLocale: "en",
          accessToken: tokenResponse.token,
          custPSPId: deviceRegInfo.pspIdentifier,
          beneAccountNo: accountNo,
          beneAppName: PSPConfig.APP_NAME,
          beneMobile: mobile,
          beneBic: bic,
          beneName: name,
          beneType: "ACCOUNT",
          accountType: accountType);
      print("ADD BENE REQUEST:::===============================");
      print(jsonEncode(addBeneficiaryRequest.toJson()));
      var response = await getIt
          .get<TransactionRepository>()
          .addBeneficiary(addBeneficiaryRequest);
      if (response.isRight()) {
        var addBeneResp = response.getOrElse(() => null);
        if (addBeneResp.success) {
          var mapBeneficiaryRequest = MapBeneficiaryRequest(
              acquiringSource:
                  await BaseRequestHelper().getCommonAcquiringSourceBean(),
              requestedLocale: "en",
              accessToken: tokenResponse.token,
              custPSPId: deviceRegInfo.pspIdentifier,
              transactionId: addBeneResp.transactionId,
              accepted: true);
          var resp2 = await getIt
              .get<TransactionRepository>()
              .mapBeneficiaryDetails(mapBeneficiaryRequest);
          showProgress.value = false;
          if (resp2.isRight()) {
            var finalResp = resp2.getOrElse(() => null);
            if (finalResp.success) {
              //Pop the Screen and display toast to say the mapping is successful
              print("successfully added the beneficiary@@@@@");
              Get.find<ContactsTransferController>().getBeneficiaries();
              if (isNewUser) {
                Get.find<AuthController>()
                    .createTempAccount(RegistrationStatus.BENEFICIARY, mobile);
              }
            } else {
              showDialogWithErrorMsg("Failed to map the account");
            }
          }
        } else {
          showDialogWithErrorMsg("Failed to add the account");
        }
      }
    }
  }

  Future getCards() async {
    var response = await getIt.get<McPaymentRepository>().getCards();
    print(response);
    if (response.isRight()) {
      return response.getOrElse(() => null);
    }
  }

  Future addCard() async {
    showProgress.value = true;
    var request = cards.CreateCardOrPayRequest();
    var response =
        await getIt.get<McPaymentRepository>().createCardOrPay(request);
    if (response.isRight()) {
      var finalResponse = response.getOrElse(() => null);
      if (finalResponse?.data?.seamless_url?.isNotEmpty ?? false) {
        // opacityValue.value=0.0;
        showProgress.value = false;
        Get.off(CommonWebViewScreen(
            title: "Add Credit Card",
            type: WebViewType.ADD_CREDIT_CARD,
            url: finalResponse.data.seamless_url));
      }
    }
    print(response);
  }

  Future payViaCreditCard(String mcPaymentCardId, num transactionAmount,
      String description, String maskedCardNumber) async {
    var request = PayCardRequest(
      register_id: mcPaymentCardId,
      amount: transactionAmount,
      description: description,
      return_url: "http://107.20.4.43:9005/v0.1/mcpayment/payment/callback",
      token: maskedCardNumber, // need to pass masked card number here
    );
    showProgress.value = true;
    var response =
        await getIt.get<McPaymentRepository>().payWithCreditCard(request);
    showProgress.value = false;
    if (response.isRight()) {
      var finalResponse = response.getOrElse(() => null);
      if (finalResponse?.data?.seamless_url?.isNotEmpty ?? false) {
        //_launchURL(finalResponse.data.seamless_url);
        Get.to(CommonWebViewScreen(
          title: "Paying with Credit card",
          type: WebViewType.PAYMENT,
          url: finalResponse.data.seamless_url,
        ));
      }
    }
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
      seconds.value = 120;
    }
  }

  String constructTime(int seconds) {
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    countDownTimeString.value = formatTime(minute) + ":" + formatTime(second);
    return countDownTimeString.value;
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  dynamic showDialogWithErrorMsg(String msg) {
    showProgress.value = false;
    getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(desc: msg));
  }
}
