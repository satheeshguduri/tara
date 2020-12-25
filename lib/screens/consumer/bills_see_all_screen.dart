import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/widgets/rounded_card_button.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/common_bills_payments_list.dart';
import '../../common/constants/values.dart';


class BillsPaymentScreen extends StatefulWidget {
  BillsPaymentScreen({Key key}) : super(key: key);
  @override
  BillsPaymentScreenState createState() => BillsPaymentScreenState();
}

class BillsPaymentScreenState extends BaseState<BillsPaymentScreen>{

  var prePaidTitleArray = ["Pulsa\nPacket Data","PLN\nPrepaid", "Internet", "E-Money","Voucher\nGame"];
  var prePaidIconsArray = [Assets.MOBILE_ICON,Assets.INTERNET_ICON, Assets.PLN_ICON, Assets.BJPS_ICON,Assets.MOBILE_ICON];

  var postPaidTitleArray = ["BPJS","Pascabayar", "PLN\nPostpaid", "PDAM"];
  var postPaidIconsArray = [Assets.MOBILE_ICON,Assets.INTERNET_ICON, Assets.PLN_ICON, Assets.BJPS_ICON];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
            children: [gridViewHeadingText(Strings.prepaid),
                       Container(height: 180,child: paidGrid(prePaidTitleArray,prePaidIconsArray)),
                       gridViewHeadingText(Strings.postpaid),
                       paidGrid(postPaidTitleArray,postPaidIconsArray)],
          ),
        ),
      ),
    );
  }

  @override
  BuildContext getContext() => context;

  AppBar getAppBar() {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
               pop();
          }
       ),
      title: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          getTranslation(Strings.allbills),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );

  }




  Widget paidGrid(List<String> titleList, List<String> iconList) {
  return  Container(
     margin: EdgeInsets.only(left: 24,right: 24),
     child: GridView.builder(
       primary: false,
       shrinkWrap: true,
       itemCount: 5,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 4,
       crossAxisSpacing: 12.0,
       mainAxisSpacing: 12.0,
       childAspectRatio: (0.69)
       ),
       itemBuilder: (context, index) {
       return  RoundedCardButton(
         buttonText: titleList[index],
         image: iconList[index],
         onPressed: (){
         Get.to(CommonBillsPaymentListView(title: titleList[index]));
           }
         );
       }
     ),
  );
}


  Widget gridViewHeadingText(String title) {
    return Container(
      margin: EdgeInsets.only(left: 16,top:16,bottom: 16),
      alignment: Alignment.centerLeft,
      child: Text(
                getTranslation(title),
                style: BaseStyles.topBarTextStyle,
              ),
    );
  }
}