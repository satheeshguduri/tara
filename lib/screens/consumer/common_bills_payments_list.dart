
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/helpers/biller_helper.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/common_bills_products_list.dart';
import '../../common/constants/values.dart';


class CommonBillsPaymentListView extends StatefulWidget {
  final List<BillProductDataBean> data;
  final BillProductsResponse response;
  CommonBillsPaymentListView({Key key,this.data,this.response}) : super(key: key);

  @override
  CommonBillsPaymentListViewState createState() => CommonBillsPaymentListViewState();

}

class CommonBillsPaymentListViewState extends BaseState<CommonBillsPaymentListView>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context,index){
              return Column(
                children: [
                  ListTile(
                    onTap: ()async{
                      List<BillProductDataBean> data = BillerHelper().getProductsByBiller(widget.response, widget.data[index].category,widget.data[index].biller);
                      Get.to(CommonBillsProductsListView(data:data));
                    },
                    leading: Image.asset("assets/images/avatar-11.png",height: 32,width: 32),
                    title: Text(widget.data[index].biller),
                    trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],size: 24,),
                  ),
                  Divider()
                ],
              );
            },

          )

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
            // // Navigator.pop(context, false);
            // if (widget.isFromHomeTopBar) {
            //   Get.offAll(Utils().getLandingScreen());
            // } else {
            pop();
            // }
          }),
      title: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          // getTranslation(Strings.profile),
          widget.data[0].category,
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );

  }

}