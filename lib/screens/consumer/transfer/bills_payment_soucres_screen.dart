import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/to_address_response.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/mcpayment/card_data.dart';
import 'package:tara_app/models/order_management/orders/order_request.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/my_account/connect_new_account_select_ank.dart';
import 'package:tara_app/screens/consumer/transfer/enter_cvv.dart';
import 'package:tara_app/utils/locale/utils.dart';

enum AccountsEntryPoint {
  BILLS,
  MY_ACCOUNTS,
  ORDERS
}

class BillsPaymentsSourcesScreen extends StatefulWidget {
  final BillDetailsData billDetailsData;
  final AccountsEntryPoint entryPoint;
  final OrderRequest orderRequest;
  final CustomerProfile merchantProfile;
  BillsPaymentsSourcesScreen(
      {Key key,
      this.billDetailsData,
        this.orderRequest,
        this.merchantProfile,
      this.entryPoint = AccountsEntryPoint.MY_ACCOUNTS})
      : super(key: key);
  @override
  BillsPaymentsSourcesScreenState createState() =>
      BillsPaymentsSourcesScreenState();
}

class BillsPaymentsSourcesScreenState
    extends BaseState<BillsPaymentsSourcesScreen> {
  BillController billController = Get.find();
  TransactionController transferController = Get.find();
  List<CardData> creditCardsData;
  CustomerProfileDetailsResponse debitCardsData;

  @override
  void init() async {
    billController.creditCardsData.value =
        await transferController.getCards(); //
    var data = await transferController.getCustomerProfile2(); // debit cards
    billController.debitCardsData.value = data?.mappedBankAccounts;
  }

  @override
  Widget build(BuildContext context) {
    showIfFalse();
    return Scaffold(
      appBar: CustomAppBarWidget(
          title: getTranslation(
              isFromMyBills ? Strings.PAYMENT : Strings.MY_ACCOUNTS),
          addNewWidgetShow: false),
      body: Obx(() => SafeArea(child: getContainer()).withProgressIndicator(
          showIndicator: transferController.showProgress.value)),

      // bottomNavigationBar: isFromMyBills?nextButtonWidget():Container(),
    );
  }

  bool get isFromMyBills => widget.entryPoint == AccountsEntryPoint.BILLS || widget.entryPoint == AccountsEntryPoint.ORDERS;

  Widget getContainer() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Commented for Demo
                  isFromMyBills ? transactionDetailRow() : Container(),
                  SizedBox(height: 32),
                  defaultCardRow(),
                  SizedBox(height: 24),
                  creditCardRow(),
                  SizedBox(height: 24),
                  otherCardsRow(),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
          isFromMyBills ? nextButtonWidget() : Container()
        ],
      ),
    );
  }

  Widget transactionDetailRow() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff7f7fa),
      ),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x1a000000),
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  color: AppColors.elevation_off_2_2_2
                  // color: Colors.black

                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text("Transaction Details",
                        style: TextStyle(
                            color: AppColors.color_black_100_2_2_2,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.ic_bca,
                        width: 48,
                        height: 24,
                      ),
                      //TODO ICON TO LOAD FROM NETWORK
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                          width: Get.width * 0.7,
                          child: Text(
                            getProductOrMerchantName(),
                            style: TextStyle(
                                color: AppColors.color_black_100_2_2_2,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  // .withPad(
                  // padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8)),

                  SizedBox(height: 16),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.black,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ).withPad(padding: EdgeInsets.only(left: 16, right: 12)),
                  SizedBox(
                    height: 18,
                  ),
                  getLabeledView().withPad(padding: EdgeInsets.all(8)),
                  // getLabeledView(widget.billDetailsData.category).withPad(padding: EdgeInsets.all(8)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getProductOrMerchantName(){
    if(widget.entryPoint == AccountsEntryPoint.BILLS){
      return widget.billDetailsData.productName;
    }else{
      return widget.merchantProfile.firstName;
    }
  }
  double getAmount(){
    if(widget.entryPoint == AccountsEntryPoint.BILLS){
      return widget.billDetailsData.amount;
    }else{
      return widget.orderRequest.price;
    }
  }
  String getOrderId(){
    if(widget.entryPoint == AccountsEntryPoint.BILLS){
      return widget.billDetailsData.inquiryId.toString();
    }else{
      return widget.orderRequest.orderId;
    }
  }

  Widget creditCardRow() {
    if (billController?.creditCardsData?.value?.isNotEmpty ?? false) {
      return Container(
        // height:100,
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit Card
            Text("Credit Cards",
                style: const TextStyle(
                    color: AppColors.color_black_100_2_2_2,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0)),
            SizedBox(
              height: 15,
            ),
            // Mask
            gridViewOfCreditCards()
          ],
        ),
      );
    } else {
      // return Text("test");
      return showAddNewWidget(false);
    }
  }

  Widget nextButtonWidget() {
    return Obx(
      () => Container(
        height: 48,
        margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: billController.paymentNextColor.value),
        alignment: Alignment.center,
        child: Text(
          getTranslation(Strings.next),
          textAlign: TextAlign.center,
          style: billController.paymentTextStyle.value,
        ),
      ).onTap(onPressed: () async {
        if (billController.paymentClickable.value) {
          showIfFalse();
          if (billController.isDebitCard.value ||
              billController.isDefaultSelected.value) {
            enterMPINBottomSheet(billController.selectedDebitCard);
            // transferController.payNow(mobileNumber: billController.mobileNumber,amount1:billController.debitCardAmount,remarks1: billController.debitCardDesc,bic1: billController.debitCardBic,cvv1: billController.debitCardCvv,initiatorAccountId1:billController.debitCardAccountId,benId1: billController.debitCardBenId);
          } else {
            // transferController.paymentInitiation(billController.creditCardId,billController.creditCardAmount, billController.creditCardDesc, billController.creditCardMaskedCardNumber);

            // differentiate cart and bill payments
            if(widget.entryPoint == AccountsEntryPoint.BILLS ||  widget.entryPoint == AccountsEntryPoint.ORDERS) {
              await transferController.paymentInitiation(
                  cardId: billController.creditCardId,
                  amount: billController.creditCardAmount,
                  desc: billController.creditCardDesc,
                  maskAcNum: billController.creditCardMaskedCardNumber,
                  toAddress: ToAddressResponse(
                      customerProfile:
                      CustomerProfile(firebaseId: "BillPayment")),
                  isFromCreditCard: true,
                  trContext: TransactionContext.BILL_PAYMENT);
            }else{
              await transferController.paymentInitiation(
                  cardId: billController.creditCardId,
                  amount: billController.creditCardAmount,
                  desc: billController.creditCardDesc,
                  maskAcNum: billController.creditCardMaskedCardNumber,
                  toAddress:ToAddressResponse(
                      customerProfile:
                      widget.merchantProfile),
                  isFromCreditCard: true,
                  trContext: TransactionContext.BILL_PAYMENT);
            }
            // transferController.payViaCreditCard();
          }
        }
      }),
    );
  }

  @override
  BuildContext getContext() => context;

  void showIfTrue() {
    billController.paymentClickable.value = true;
    billController.paymentNextColor.value = AppColors.bottom_border_color;
    billController.paymentTextStyle.value = BaseStyles.addNewBankAccount;
  }

  void showIfFalse() {
    billController.paymentClickable.value = false;
    billController.paymentNextColor.value =
        AppColors.billerPaymentNextButtonColor;
    billController.paymentTextStyle.value = TextStyles.bUTTONGrey3222;
  }

  Widget commonRowTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, right: 16),
      child: Text(
        title,
        style: TextStyles.caption222TextStyle,
      ),
    );
  }

  void accountsSettingsBottomSheet(
          MappedBankAccountsBean mappedBankAccountsBean) =>
      showModalBottomSheet(
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext bc) {
            return Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslation(Strings.ACCOUNT_SETTINGS),
                            style: BaseStyles.topBarTextStyle,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslation(Strings.set_as_default_acc),
                                  style: BaseStyles.bankNameTextStyle,
                                ),
                                Switch(
                                  value: mappedBankAccountsBean.isDefault,
                                  activeColor: AppColors.pale_turquoise,
                                  onChanged: (value) {
                                    //TODO GET API on CHANGING THE DEFAULT VALUE
                                  },
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslation(Strings.balance_check),
                                  style: BaseStyles.bankNameTextStyle,
                                ),
                                Image.asset(Assets.ic_arrow_right)
                              ],
                            ).onTap(onPressed: () {
                              //TODO: BALANCE CHECK API
                            }),
                          ),
                          Divider(),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslation(Strings.mpin),
                                  style: BaseStyles.bankNameTextStyle,
                                ),
                                Image.asset(Assets.ic_arrow_right)
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            color: Colors.white,
                            child: Text(
                              getTranslation(Strings.delete_account),
                              style: BaseStyles.deleteAccountStyle,
                            ),
                          ).onTap(onPressed: () {
                            // TODO: delete api should be called here
                            Get.back();
                            transferController
                                .deleteBankAccount(mappedBankAccountsBean);
                          })
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          });

  Widget debitCardtransactionDetailRow(int index) {
    return Container(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
            // height: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: AppColors.elevation_off_2_2_2),
            child: Image.asset(Assets.ic_bca),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 19),
          ),
          // Expanded(child: SizedBox()),
          Obx(() => Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              //width: 50,
              child: isMatched(billController.debitCardSelectedIndex.value,
                      index.toString())
                  ? getSvgImage(
                      imagePath: Assets.assets_icon_c_check_solid,
                      height: 24.0,
                      width: 24.0)
                  // margin: EdgeInsets.only(top: 8),
                  : Container())),
        ],
      ),
    );
  }

  Widget debitCardAmountRow() {
    return Container(
        margin: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text("Rp 12.500.000", style: TextStyles.cardAmountTextStyle));
  }

  Widget debitCardNumberRow(MappedBankAccountsBean mappedBankAccounts) {
    return Container(
        margin: EdgeInsets.only(
          left: 16,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
            Utils()
                .getMaskedAccountNumber(mappedBankAccounts.maskedAccountNumber),
            style: TextStyles.cardNumberTextStyle));
  }

  Widget getLabeledView() {
    return Column(children: [
      // getProductCodeTextTextView(),
      getNominalTextView(),
      getProductNameTextTextView(),
    ]);
  }

  Widget getProductCodeTextTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getTranslation(Strings.code),
            style: BaseStyles.purchaseLabelTextStyle),
        Text("${widget.billDetailsData.productCode}",
            style: TextStyles.bUTTONWhite2)
      ],
    ).withPad(padding: EdgeInsets.all(5));
  }

  Widget getProductNameTextTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Order ID",
            style: TextStyle(
                color: const Color(0xff666666),
                fontWeight: FontWeight.w400,
                fontSize: 14.0)),
        Container(
            width: Get.width * 0.6,
            child: Text(
              "${getOrderId()}",
              style: TextStyle(
                  color: AppColors.color_black_100_2_2_2,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ))
      ],
    ).withPad(padding: EdgeInsets.all(5));
    ;
  }

  Widget getNominalTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Value",
            style: TextStyle(
                color: const Color(0xff666666),
                fontWeight: FontWeight.w400,
                fontSize: 14.0)),
        Text(
          getTranslation(Strings.RP) + " " + "${getAmount()}",
          style: TextStyle(
              color: AppColors.color_black_100_2_2_2,
              fontWeight: FontWeight.w700,
              fontSize: 14.0),
        )
      ],
    ).withPad(padding: EdgeInsets.all(5));
  }

  Widget defaultCardRow() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // My Default Account
          Text("My Default Account",
              style: const TextStyle(
                  color: AppColors.color_black_100_2_2_2,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0)),
          SizedBox(
            height: 15,
          ),
          getDefaultDebitCardsOrAddNewCard()
        ],
      ),
    );
  }

  Widget getDefaultDebitCardsOrAddNewCard() {
    if (billController?.debitCardsData?.value?.isNotEmpty ?? false) {
      var defaultCard = billController?.debitCardsData?.value
          ?.firstWhere((element) => element.isDefault, orElse: () => null);

      if (defaultCard != null) {
        billController.selectedDebitCard = defaultCard;
        showIfTrue();
        return Container(
          margin: EdgeInsets.only(right: 16),
          height: 72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border:
                  Border.all(color: AppColors.color_mint_100_2_2_2, width: 1),
              color: const Color(0x40b2f7e2)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(23, 18, 34, 22),
                child: getSvgImage(
                    imagePath: Assets.illu_default_card,
                    width: 56.0,
                    height: 34.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Assets.ic_bank1,
                        fit: BoxFit.fitHeight,
                        height: 11,
                      ).paddingOnly(right: 5),
                      // Jenius
                      Text(defaultCard.bankName,
                          maxLines: 1,
                          style: const TextStyle(
                              color: AppColors.color_black_100_2_2_2,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                      Utils().getMaskedAccountNumber(
                          defaultCard.maskedAccountNumber),
                      style: const TextStyle(
                          color: AppColors.color_black_100_2_2_2,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0)),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Spacer(),
              Obx(() => billController.isDefaultSelected.value
                  ? Visibility(
                      visible: widget.entryPoint == AccountsEntryPoint.BILLS ||  widget.entryPoint == AccountsEntryPoint.ORDERS,
                      child: Center(
                        child: getSvgImage(
                                imagePath: Assets.assets_icon_c_check_solid,
                                height: 24.0,
                                width: 24.0)
                            .paddingOnly(right: 8),
                      ),
                    )
                  : Container())
            ],
          ),
        ).onTap(onPressed: () {
          if (isFromMyBills) {
            billController.debitCardSelectedIndex.value = "-1";
            billController.creditCardSelectedIndex.value = "-1";
            billController.isDefaultSelected.value = true;
            billController.selectedDebitCard = defaultCard;
            showIfTrue();
            billController.isDebitCard.value = false;
            billController.isCreditCard.value = false;
            billController.debitCardBic = defaultCard.bic;
            billController.debitCardCvv = "123";
            billController.debitCardDesc = "Bill payment";
          } else {
            accountsSettingsBottomSheet(defaultCard);
            //show nottomsheet to show the design for
          }
        });
      } else {
        return showAddNewWidget(true);
      }
    } else {
      return showAddNewWidget(true);
    }
  }

  bool isMatched(String current, String index) => current == index;

  Widget creditCardTransactionDetailRow(CardData creditCardData, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            child: Text(creditCardData.bankIssuer,
                style: TextStyles.cardAmountTextStyle,
                overflow: TextOverflow.ellipsis),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              left: 16,
            ),
          ),
          Obx(() => Visibility(
                visible: widget.entryPoint == AccountsEntryPoint.BILLS ||  widget.entryPoint == AccountsEntryPoint.ORDERS,
                child: Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    //width: 50,
                    child: isMatched(
                            billController.creditCardSelectedIndex.value,
                            index.toString())
                        ? getSvgImage(
                            imagePath: Assets.assets_icon_c_check_solid,
                            height: 24.0,
                            width: 24.0)
                        // margin: EdgeInsets.only(top: 8),
                        : Container()),
              )),
        ],
      ),
    );
  }

  Widget creditCardNumberRow(CardData creditCardData) {
    return Container(
        margin: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(creditCardData.maskedCardNumber,
            style: TextStyles.cardAmountTextStyle));
  }

  Widget creditCardNameRow(CardData creditCardData) {
    return Container(
        margin: EdgeInsets.only(
          left: 16,
        ),
        alignment: Alignment.centerLeft,
        child: Text(creditCardData.cardHolderName,
            style: TextStyles.cardNumberTextStyle));
  }

  /*void enterMPINBottomSheet(mappedBankAccountsBean) => showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return EnterCVV(amount:widget.billDetailsData.amount.toString(),billsCatagoryData:widget.billDetailsData.category,mappedBankAccountsBean: mappedBankAccountsBean,);


      }
  );*/
  void enterMPINBottomSheet(MappedBankAccountsBean mappedBankAccountsBean) {
    Get.to(EnterCVV(
      amount: widget.billDetailsData?.amount?.toString(),
      billsCatagoryData: widget.billDetailsData?.category,
      mappedBankAccountsBean: mappedBankAccountsBean,
      orderRequest: widget.orderRequest,
      merchantProfile: widget.merchantProfile,
    ));

  }

  Widget otherCardsRow() {
    if (billController?.debitCardsData?.value?.isNotEmpty ?? false) {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit Card
            Text("Other Accounts",
                style: const TextStyle(
                    color: AppColors.color_black_100_2_2_2,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0)),
            SizedBox(
              height: 15,
            ),
            gridViewOfDebitCards()
            // Mask
            // Expanded(child: gridViewOfDebitCards())
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget gridViewOfDebitCards() {
    if ((billController?.debitCardsData?.value?.length ?? 0) == 1) {
      return showAddNewWidget(true);
    } else {
      return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 9,
          shrinkWrap: true,
          childAspectRatio: 2.23,
          physics: ScrollPhysics(),
          children: getListWithAddNewDebit()
          //filteredList.map((categoryItem) => getCardListTile(categoryItem)).toList()
          );
    }
  }

  Widget gridViewOfCreditCards() {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 9,
        shrinkWrap: true,
        childAspectRatio: 2.23,
        physics: ScrollPhysics(),
        children: getListWithAddNewCredit());
  }

  getListWithAddNewDebit() {
    List<Widget> list = billController?.debitCardsData?.value
        .map((e) => getDebitCardListTile(e))
        .toList();
    list.insert(0, showAddNewWidget(true));
    return list;
  }

  getListWithAddNewCredit() {
    List<Widget> list = billController.creditCardsData.value
        .map((e) => getCreditCardListTile(e))
        .toList();
    list.insert(0, showAddNewWidget(false));
    return list;
  }

  Widget getDebitCardListTile(MappedBankAccountsBean bean) {
    var index = billController?.debitCardsData?.value?.indexOf(bean);
    if (index != null) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x1a000000),
                  offset: Offset(0, 1),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: AppColors.elevation_off_2_2_2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.ic_bank1,
                  fit: BoxFit.fitWidth,
                  height: 11,
                ).paddingOnly(right: 10),
                // Jenius
                Expanded(
                  child: Text(bean.bankName,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.color_black_100_2_2_2,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 24,
                  child: Text(
                      Utils().getMaskedAccountNumber(bean.maskedAccountNumber),
                      style: const TextStyle(
                          color: const Color(0xff1c1d22),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0)),
                ),
                Obx(() => Visibility(
                      visible: widget.entryPoint == AccountsEntryPoint.BILLS ||  widget.entryPoint == AccountsEntryPoint.ORDERS,
                      child: isMatched(
                              billController.debitCardSelectedIndex.value,
                              index.toString())
                          ? getSvgImage(
                              imagePath: Assets.assets_icon_c_check_solid,
                              height: 24.0,
                              width: 24.0)
                          // margin: EdgeInsets.only(top: 8),
                          : Container(),
                    )),
              ],
            )
          ],
        ),
      ).onTap(onPressed: () {
        if (isFromMyBills) {
          billController.debitCardSelectedIndex.value = index.toString();
          billController.creditCardSelectedIndex.value = "-1";
          billController.isDefaultSelected.value = false;
          billController.selectedDebitCard = bean;
          showIfTrue();
          billController.isDebitCard.value = true;
          billController.isCreditCard.value = false;
          billController.debitCardBic = bean.bic;
          billController.debitCardCvv = "123";
          billController.debitCardDesc = "Bill payment";
        } else {
          accountsSettingsBottomSheet(bean);
        }
      });
    } else {
      return showAddNewWidget(true);
    }
  }

  Widget showAddNewWidget(bool isDebit) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              color: AppColors.input_field_line_off_2_2_2,
              strokeWidth: 1,
              dashPattern: [4, 4],
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: Container(
                  height: 72,
                  color: AppColors.grey3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
// Add New
                      getSvgImage(
                          imagePath: Assets.assets_icon_p_plus,
                          width: 20.0,
                          height: 20.0),
                      Text("Add New",
                          style: const TextStyle(
                              color: AppColors.color_black_100_2_2_2,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ),
            ),
          ).onTap(onPressed: () {
            if (isDebit) {
              Get.to(ConnectNewAccountSelectBank());
            } else {
              transferController.addCard();
            }
            //  Get.to(MyAccountsSeeAllScreen());
          }),
        ),
        SizedBox(
          width: 8,
        )
      ],
    );
  }

  Widget getCreditCardListTile(CardData creditCardData) {
    var index = billController.creditCardsData.indexOf(creditCardData);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x1a000000),
                offset: Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          color: AppColors.elevation_off_2_2_2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                Assets.ic_bank1,
                fit: BoxFit.fitWidth,
                height: 11,
              ).paddingOnly(right: 10),
              // Jenius
              Expanded(
                child: Text(creditCardData.bankIssuer,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.color_black_100_2_2_2,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.0,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 24,
                child: Text(creditCardData.maskedCardNumber,
                    style: const TextStyle(
                        color: const Color(0xff1c1d22),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ),
              Obx(() => isMatched(billController.creditCardSelectedIndex.value,
                      index.toString())
                  ? getSvgImage(
                      imagePath: Assets.assets_icon_c_check_solid,
                      height: 24.0,
                      width: 24.0)
                  // margin: EdgeInsets.only(top: 8),
                  : Container())
            ],
          )
        ],
      ),
    ).onTap(onPressed: () {
      if (isFromMyBills) {
        billController.creditCardSelectedIndex.value = index.toString();
        billController.debitCardSelectedIndex.value = "-1";
        billController.isDefaultSelected.value = false;
        showIfTrue();
        billController.isDebitCard.value = false;
        billController.isCreditCard.value = true;
        billController.creditCardId = creditCardData?.id?.mcPaymentCardId;
        billController.creditCardAmount = widget.billDetailsData.amount;
        billController.creditCardDesc = "Gift Only";
        billController.creditCardMaskedCardNumber =
            creditCardData.maskedCardNumber;
      } else {
        //TODO How to get the deatails of credit card account setting oprion
      }
    });
  }
}
