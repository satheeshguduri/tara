
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/helpers/biller_helper.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/common_bills_products_list.dart';
import '../../common/constants/values.dart';


class CommonBillsPaymentListView extends StatefulWidget {
  final List<BillProductDataBean> data;
  final bool pulsaAndPaketData;
  CommonBillsPaymentListView({Key key,this.data,this.pulsaAndPaketData=false}) : super(key: key);

  @override
  CommonBillsPaymentListViewState createState() => CommonBillsPaymentListViewState();

}

class CommonBillsPaymentListViewState extends BaseState<CommonBillsPaymentListView>{

  BillController controller = Get.find<BillController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: getAppBar(),
        appBar: CustomAppBarWidget(title: widget.data[0].category,addNewWidgetShow: false,),

      body: SafeArea(
        child: pulsaPaketDataOrCommonListView(widget.data),

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
        //  icon: Icon(Icons.arrow_back),
          icon:getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,width: 24.0,height:24.0),
          onPressed: () {
            pop();
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

  Widget pulsaPaketDataOrCommonListView(List<BillProductDataBean> dataBean) {

    return
      ListView.builder(
        itemCount:dataBean.length,
        itemBuilder: (context,index){
          return Column(
            children: [
              ListTile(
                onTap: ()async{
                  List<BillProductDataBean> data = controller.getProducts(dataBean[index]);
                  Get.to(CommonBillsProductsListView(data:data));
                },
                leading: Image.asset("assets/images/avatar-11.png",height: 32,width: 32),
                title: Text(dataBean[index].biller),
                trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],size: 24,),
              ),
              Divider()
            ],
          );
        },

      );
  }

}