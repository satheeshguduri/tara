import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/helpers/biller_helper.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/rounded_card_button.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
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

  BillProductsResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
          child: getTypesWidget()
      ),
    );
  }


  getFuture(){

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
  getData() async {
    return BillerHelper().getCategories(response);
  }

  getTypes() async {
    response = await BillerHelper().getData();
    return BillerHelper().getTypes(response);
  }
  getCategories(String type) async {
    return BillerHelper().getCategoriesByType(response, type);
  }

  Widget getCategoriesWidgets(type) {
    return FutureBuilder(
      future: getCategories(type),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<BillProductDataBean> data = snapshot.data;
          print(data.toList().toString());
          return paidGrid(data);
        }
        return BaseWidgets.getIndicator;
      },
    );

  }




  Widget getTypesWidget() {
      return FutureBuilder(
        future: getTypes(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<BillProductDataBean> data = snapshot.data;
            print(data.toList().toString());
            return ListView(
              children: data.map((e) => Column(
                children: [
                  gridViewHeadingText(e.type),
                  getCategoriesWidgets(e.type)
                ],
              )).toList(),
            );
          }
          return BaseWidgets.getIndicator;
        },
      );

  }


  getImage(String categoryName){
    switch(categoryName){
      case "Paket Data":
        return Assets.BJPS_ICON;
        break;
      case "BPJS":
        return Assets.BJPS_ICON;
        break;
      default:
        return Assets.INTERNET_ICON;
        break;
    }
  }
  Widget paidGrid(List<BillProductDataBean> categories) {
  return  Container(
     margin: EdgeInsets.only(left: 24,right: 24),
     child: GridView.builder(
       primary: true,
       shrinkWrap: true,
       itemCount: 5,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 4,
       crossAxisSpacing: 12.0,
       mainAxisSpacing: 12.0,
       childAspectRatio: (0.68)
       ),
       itemBuilder: (context, index) {
       return  RoundedCardButton(
         buttonText: categories[index].category,
         image: getImage(categories[index].category),
         onPressed: () async{
           List<BillProductDataBean> data = BillerHelper().getBillersByCategory(response, categories[index].category);
           Get.to(CommonBillsPaymentListView(data:data));
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