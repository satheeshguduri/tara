import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/home_customer_screen.dart';

class TransactionDetailScreen extends StatefulWidget {
  TransactionDetailScreen({Key key}) : super(key: key);

  @override
  _TransactionDetailScreenState createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState
    extends BaseState<TransactionDetailScreen> {
  final key = new GlobalKey<ScaffoldState>();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      appBar: _buildAppBar(context),
      body: SafeArea(child:updateViews(),),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget updateViews()
  {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 32,),
            bigCircle(),
            transactionSuccessTextWidget(),
            dateTimeTextWidget(),
            transactionIdTextWidget(),
            getTransactionDetailsWidget(),
            Container(
              margin: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: downloadAndShareWidget(getTranslation(Strings.DOWNLOAD)),
                  ),
                  Expanded(
                    flex: 5,
                    child: downloadAndShareWidget(getTranslation(Strings.SHARE)),
                  ),
                ],
              ),
            ),
            Container(height: 32,),
          ],
  ),
      ),
    );
  }

   AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
             pushReplacement(HomeCustomerScreen());
          }
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.TRANSACTION_DETAIL),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  Widget bigCircle() {
    return Container(
        width: 124,
        height: 124,
        decoration: new BoxDecoration(
          color: Color(0xffd8d8d8),
          shape: BoxShape.circle,
        ),
        child:Container());
  }

  Widget transactionSuccessTextWidget()
  {
    return Container(
      margin: EdgeInsets.only(top:16,),
      child: Text(
          getTranslation(Strings.TRANSFER_SUCCESS),
          style: BaseStyles.transactionSuccessTextStyle,
          textAlign: TextAlign.center
      ),
    );
  }

  Widget dateTimeTextWidget()
  {
    return Container(
      margin: EdgeInsets.only(top:8,bottom: 8),
      child: Text(
          "Tuesday, 4 Sep 2020 - 12:30 PM",
          style: BaseStyles.dateAndTimeTextStyle,
          textAlign: TextAlign.center
      ),
    );
  }

  Widget transactionIdTextWidget()
  {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Text(
          "Transaction ID: TAR2212",
          style: BaseStyles.dateAndTimeTextStyle,
          textAlign: TextAlign.center
      ),
    );
  }

  Widget getTransactionDetailsWidget()
  {
    return Container(
      margin: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            boxShadow: [BoxShadow(
                color: const Color(0x24000000),
                offset: Offset(0,2),
                blurRadius: 6,
                spreadRadius: 0
            ), BoxShadow(
                color: const Color(0x14000000),
                offset: Offset(0,0),
                blurRadius: 2,
                spreadRadius: 0
            )] ,
            color: Colors.white
        ),
      child:Container(
        margin: EdgeInsets.all(16),
        child:  Column(
          children: [
            Container(
                padding: EdgeInsets.only(left: 8,bottom: 8,top: 8,right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(8)
                    ),
                    border: Border.all(
                        color: Colors.grey[300],
                        width: 1
                    ),
                    color: Colors.white
                ),
              child: Container(
                margin: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8),
                      child: Text(
                        getTranslation(Strings.AMOUNT),
                        style: BaseStyles.amountTextStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8),
                      child: Text(
                        "Rp 100.000",
                        style: BaseStyles.topBarTextStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getFromTransferredToWidget(getTranslation(Strings.TRANSFER_TO),"RAFLY NURFALLAH", "Mandiri ••••4421"),
            getFromTransferredToWidget(getTranslation(Strings.FROM),"Budi Sudarso", "BCA - ****1234"),
          ],
        ),
      ) ,
    );
  }

  Widget getFromTransferredToWidget(String title,String name, String accountNumber)
  {
    return Container(
      margin: EdgeInsets.only(top: 8,bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4,bottom: 2),
            child: Text(
                title,
                style: BaseStyles.enterMPINTextStyle,
                textAlign: TextAlign.left
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4,bottom: 4),
                  child: Text(
                      name,
                      style: BaseStyles.transaction_account_name_textStytle,
                      textAlign: TextAlign.left
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8,right: 8),
                    width: 4,
                    height: 4,
                  decoration: new BoxDecoration(
                    color: Color(0xffb0b4c1),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4,bottom: 4),
                  child: Text(
                      accountNumber,
                      style: BaseStyles.amountTextStyle,
                      textAlign: TextAlign.left
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget downloadAndShareWidget(String name)
  {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 45,
        margin: EdgeInsets.only(bottom: 16,top: 8,left: 8,right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            border: Border.all(
                color: AppColors.uncheck_color,
                width: 1
            ),
            color: Colors.white
        ),
        alignment: Alignment.center,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              name==getTranslation(Strings.DOWNLOAD)?Image.asset(Assets.ic_download, fit: BoxFit.fill):Image.asset(Assets.ic_share, fit: BoxFit.fill),
              Container(
                margin: EdgeInsets.only(left: 2),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: BaseStyles.addNewBankAccount,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


