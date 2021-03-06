import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/common/widgets/home_top_bar_widget.dart';
import 'package:tara_app/common/widgets/rounded_card_button.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/controller/home_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/screens/agent/transaction_history.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/transaction_detail_screen.dart';
import 'package:tara_app/screens/consumer/transfer/bills_payment_soucres_screen.dart';
import 'package:tara_app/screens/consumer/transfer_contacts_selection_screen.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/screens/consumer/transfer_to_tara_user.dart';
import 'package:tara_app/utils/locale/utils.dart';
import '../../common/constants/values.dart';
import 'bills_see_all_screen.dart';
import 'common_bills_payments_list.dart';
import 'my_account/myaccounts_see_all_screen.dart';
import 'package:tara_app/common/widgets/see_all_widget.dart';
import 'package:async/async.dart';
import 'package:tara_app/screens/consumer/bills_see_all_screen.dart';




class HomeCustomerWidget extends StatefulWidget {
  HomeCustomerWidget({Key key}) : super(key: key);

  @override
  _HomeCustomerWidgetState createState() => _HomeCustomerWidgetState();
}

class _HomeCustomerWidgetState extends BaseState<HomeCustomerWidget> {

 // var myAccountArray = ["tara cash","tara reqards", "tara score"];
  var taraServicesImages = [Assets.assets_icon_tara_cash,Assets.logo_tara_rewards, Assets.logo_tara_score];
  var transferToArray = ["Tara\nUsers","Bank\nAccount", "E-Money", "My\nAccount"];
  var paymentOptionsArray = ["Mobile","Internet", "PLN", "BPJS"];
  var paymentOptionsIconsArray = [Assets.MOBILE_ICON,Assets.INTERNET_ICON, Assets.PLN_ICON, Assets.BJPS_ICON];

  BillController controller = Get.find<BillController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Container(
            height: 260,
            child: HomeTopBar(appName: "Consumer"),
          ),
          Expanded(
            child: Container(
//              margin: EdgeInsets.only(bottom: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getTaraServicesWidget(),
                    // getTransferToWidget()
                    SizedBox(height: 16,),
                    getMyAccountsFuture(),
                    SizedBox(height: 16,),
                    getBillPaymentFuture(),
                    SizedBox(height: 16,),
                    getTransactionsFuture(),
                    Container(
                      height: 32,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTaraServicesWidget()
  {
    return Container(
      height: 105,//95
      margin: EdgeInsets.only(left: 16,),
      child: Column(
        children: [
          Container(
            child: getTitleAndSeeAllText(Strings.TARA_SERVICES).marginOnly(top:0,bottom:10),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 45,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: taraServicesImages.length,
                itemBuilder: (context, index) {
                  return getMyAccountsGridItem(taraServicesImages[index],index);
                }),
          )
        ],
      )
    );
  }
  Widget  getTransactionsFuture() {


    return Obx(()=>getTransactionsWidget(homeController.transactionsHistory.value));

    // return FutureBuilder(
    //   future: homeController.transactionsMemorizer.runOnce(()=> Get.find<TransactionController>().getTransactions()),
    //   builder: (context,snapshot){
    //     if(snapshot.connectionState==ConnectionState.done)
    //     {
    //       if(snapshot.hasData){
    //         TransactionHistoryResponse data = snapshot.data;
    //         return getTransactionsWidget(data);
    //       }else if (snapshot.hasError){
    //         return Container();
    //       }else{
    //         return Container();
    //       }
    //     }else{
    //       return BaseWidgets.getIndicator;
    //     }
    //
    //   },
    // );

  }
  Widget  getMyAccountsFuture() {
      return FutureBuilder(
        initialData: Get.find<HomeController>().accountsHistory,
        // future: homeController.accountMemorizer.runOnce(()=> Get.find<TransactionController>().getCustomerProfile2()),
        future: Get.find<TransactionController>().getCustomerProfile2(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done)
            {
              if(snapshot.hasData){
                CustomerProfileDetailsResponse data = snapshot.data;
                if(data?.mappedBankAccounts?.isNotEmpty??false) {
                  return getMyAccountsWidget(data.mappedBankAccounts);
                }else return Container();
              }else if (snapshot.hasError){
                return Container();
              }else{
                return addNewAccountIcon();
              }
            }else{
            return Container();
                // return BaseWidgets.getIndicator;
          }

        },
      );
   }

  Widget getMyAccountsGridItem(String imagePath,int index)
  {
//    if (accountName == "tara wallet")
//    {
      return // Container
        Container(
            margin: EdgeInsets.only(right: 8),
            width: getParentWidth(index),
            height:40.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
              color: Color.fromARGB(255, 19, 53, 86),
            ),
          child: Center(child:getSvgImage(
              imagePath: imagePath,
              color: Colors.white,
              height: getChildHeight(index),
              width: getChildWidth(index)
        )
          ),
        ).onTap(onPressed: (){
          getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(buttonText:"Okay",onTap:(){
                        Get.back();
                      },title:getTranslation(Strings.feature_title),
                        desc:getTranslation(Strings.feature_sub_title),
                        image:getSvgImage(imagePath: Assets.illustration_coming_soon_under_development,
                          width: 120.0,
                          height: 120.0),

          )
              );
            }
          );
  }

  Widget getTransferToWidget()
  {
    return Container(
        height: 140,
        margin: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      getTranslation(Strings.TRANSFER_TO),
                      textAlign: TextAlign.left,
                      style:BaseStyles.homeScreenHeadersStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: transferToArray.length,
                  itemBuilder: (context, index) {
                    return getTransferToGridItem(transferToArray[index]);
                  }),
            )
          ],
        )
    );
  }

  Widget getTransferToGridItem(String accountName)
  {
    return InkWell(
        onTap: (){
          if (accountName == "Bank\nAccount")
          {
            push(TransferContactsSelectionScreen());
          }
          else if (accountName == "Tara\nUsers")
          {
           push(TransferToTaraUser(isFromTaraUser:true,navBarTitle: Strings.transfer_to_tara_user));
          }
          else if (accountName == "My\nAccount")
          {
            push(BankTransferNewContact(selfTransfer: true,));
          }else if (accountName == "E-Money"){
            push(TransferToTaraUser(isFromTaraUser:false,navBarTitle: Strings.transfer_to_e_money));
          }
        },
        child:Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 76,
            height: 92,
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              boxShadow: [
                Shadows.primaryShadow,
              ],
              borderRadius: Radii.k8pxRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 18, top: 8, right: 18),
                  decoration: BoxDecoration(
                    color: AppColors.accentElement,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4,left: 4,bottom: 4,right: 4),
                  child: Text(
                    accountName,
                    textAlign: TextAlign.center,
                    style: BaseStyles.transferToItemTextStyle,
                  ),
                ),
              ],
            ),
          ),

        ));
  }

  Widget getBillPaymentFuture(){

      return FutureBuilder(
        initialData: homeController.billCategories,
        future: homeController.billsMemorizer.runOnce(()=> Get.find<BillController>().getCategories()),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData){
              List<BillProductDataBean> data = snapshot.data;
              var parseData = data;
              if(data.length>4) {
                parseData = data.sublist(0, 4);
              }
              return getPaymentWidget(parseData);
            }else if (snapshot.hasError){
              return Container();
            }else{
              return Container();
            }
          }else{
            return BaseWidgets.getIndicator;
          }

        },
      );
  }



  Widget getPaymentWidget(List<BillProductDataBean> data)
  {
    int index = 0;
    return Container(
        height: 148,//YAKUB: 140
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left:16,top: 2),
              child: getTitleAndSeeAllText(Strings.bills).marginOnly(top:0,bottom:10),
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.map((e) => RoundedCardButton(
                   imageIndex:index++,
                   buttonText: e.category,
                 // image: paymentOptionsIconsArray[0]
                    imageURL: e.logo,
                  onPressed: (){
                    List<BillProductDataBean> data = controller.getBillers(e);
                  Get.to(CommonBillsPaymentListView(data:data));
                },)
                ).toList(),
              ),
            )
          ],
        )
    );
  }

  Widget getTransactionsWidget(TransactionHistoryResponse transactions)
  {
    if(transactions?.transactionList?.isEmpty??true)
      return Container();//ErrorStateInfoWidget(title: "No Transactions Found",);// TODO return Error State widget here and  String to be configured

    var transactionsList = transactions?.transactionList;
    return Container(
        margin: EdgeInsets.only(left: 16, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child:getTitleAndSeeAllText(Strings.TRANSACTIONS)).marginOnly(top:10,bottom:8),
            Container(
              child: ListView.builder(
                padding:EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transactionsList.length>=3?3:transactionsList.length,
                itemBuilder: (context,index){
                  return getTransactionsItemWidget(transactionsList[index]);
                },
              ),
            )
          ],
        )
    );
  }

  Widget getTransactionsItemWidget(TransactionListBean transaction)
  {
    var prefix = "-";
    if(transaction.txnType == RequestType.COLLECT){
      prefix = "+";
    }
    return Container(
      margin: EdgeInsets.only(right: 16,top: 8),
      padding: EdgeInsets.all(8),
      height: 64,
      decoration:
      BoxDecoration(
          borderRadius: Radii.k8pxRadius,
          boxShadow: Shadows.shadows_list_3,
          color: AppColors.primaryBackground
      ),
      child:Center(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Rectangle
            Row(
              children: [
                Image.asset("assets/images/avatar-11.png",height: 32,width: 32,),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          Utils().getDefaultFormattedDate(DateTime.fromMillisecondsSinceEpoch(transaction.timestamp.toInt())),//"TODAY ??? 12:33",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemDateTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          transaction.counterpartName??"",
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                    ],
                  ) ,
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                prefix + transaction.amount, //"- Rp 300.000",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.grey[800],
                  
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    ).onTap(onPressed: (){
      Get.to(TransactionDetailScreen());
    });
  }

  Widget getTitleAndSeeAllText(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 7.5.toInt(),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              //getTranslation(Strings.TRANSACTIONS),
              getTranslation(title),
              textAlign: TextAlign.left,
              style: BaseStyles.homeScreenHeadersStyle,
            ),
          ),
        ),
        Expanded(
          flex: 2.5.toInt(),
                child: Container(
                padding: EdgeInsets.only(top: 8,bottom: 8),
                child: SeeAllWidget(),
            ).onTap(onPressed: (){
                  if (title == Strings.MY_ACCOUNTS)
                  {
                    // push to myaccounts
                  }
                  else if (title == Strings.bills)
                  {
                     Get.to(BillsSeeAllScreen());
                  }
                  else if (title == Strings.TRANSACTIONS)
                  {
                    Get.to(TransactionHistory());
                  }
                  else if (title == Strings.myAccounts)
                  {
                    // Get.to(MyAccountsSeeAllScreen());
                    Get.to(BillsPaymentsSourcesScreen());
                  }


                }
            ),
          ),
        ],
    );
  }



 double getParentWidth(int index) {
    if(index == 0){
      return 103.0;
    }
    else if(index == 1){
      return 112.0;
    }
    return 103.0;
  }



 double getChildHeight(int index) {

   if(index == 0){
     return 22.0;
   }
   return 18.0;
  }

 double getChildWidth(int index) {
   if(index == 0){
     return 88.0;
   }
   else if(index == 1){
     return 103.0;
   }
   return 91.0;

 }

  Widget addNewAccountIcon() {
    return Row(

      children: [
        Container(
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            color: AppColors.input_field_line_off_2_2_2,
            strokeWidth: 2,
            dashPattern: [4,4],

            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Container(
                height: 44,
                width: 44,
                color: AppColors.grey3,
                child: getSvgImage(imagePath: Assets.assets_icon_p_plus,
                    width: 24.0,
                    height: 24.0),
              ),
            ),
          ),
        ).onTap(onPressed: (){
          //Get.to(ConnectNewAccountSelectBank());
          // Get.to(MyAccountsSeeAllScreen());
          Get.to(BillsPaymentsSourcesScreen());

        }),
        SizedBox(width: 8,)
      ],



    );

  }

  Widget myAccountBankCard(MappedBankAccountsBean data){
    {
    return  Container(
          width: 172,
          height: 44,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
              boxShadow: [BoxShadow(
                  color: const Color(0x2307c9cf),
                  offset: Offset(0,4),
                  blurRadius: 4,
                  spreadRadius: 0
              )] ,
              gradient: LinearGradient(
                  begin: Alignment(1, 1),
                  end: Alignment(0, 0),
                  colors: [AppColors.myAccountGradientFirstColor, AppColors.color_mint_100_2_2_2])
          ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             getBankLogo(),
             getBankNumber(data)
           ],
         ),
      ).onTap(onPressed: (){
          getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(buttonText:"Okay",onTap:(){
            Get.back();
          },title:getTranslation(Strings.feature_title),desc:getTranslation(Strings.feature_sub_title),image:Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: const Color(0xffd8d8d8)
              )
          )
          )
          );
        }
        );

    }
  }

Widget getBankLogo() {

  return Container(
      width: 60,
      height: 20,
      margin: EdgeInsets.only(left: 8,right: 8),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(3)
          ),
          boxShadow: [BoxShadow(
              color: const Color(0x17000000),
              offset: Offset(0,2),
              blurRadius: 4,
              spreadRadius: 0
          )] ,
          color: AppColors.elevation_off_2_2_2
      ),
    child: getSvgImage(imagePath: Assets.logo_tara, width: 34.0,height: 13.0),
  );
  }

  Widget getBankNumber(MappedBankAccountsBean data) {
    return Container(
     child: Text(
            getMaskedAccountNumber(data.maskedAccountNumber),
            style: TextStyles.subtitle1222
        )
    );
  }

  Widget getMyAccountsWidget(List<MappedBankAccountsBean> parseData) {
    return Container(
        height: 105,//95
        margin: EdgeInsets.only(left: 16,),
        child: Column(
          children: [
            getTitleAndSeeAllText(Strings.myAccounts).marginOnly(top:8,bottom:8),
            Container(
              margin: EdgeInsets.only(top: 8),
              height: 44,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: parseData.length+1,
                  itemBuilder: (context, index) {
                    if(index == 0){
                      return addNewAccountIcon();
                    }else{
                      return  myAccountBankCard(parseData[index-1]);
                    }
                  }),
            )
          ],
        )
    );

  }

  String getMaskedAccountNumber(String fullString) {
    List<String> list = fullString.split('#').toList();
    return "******"+ list[1].substring(list[0].length - 4);

  }

}