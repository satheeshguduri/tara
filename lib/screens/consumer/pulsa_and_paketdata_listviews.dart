
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/helpers/biller_helper.dart';
import 'package:tara_app/controller/bill_controller.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/common_bills_products_list.dart';
import '../../common/constants/values.dart';


class PulsaAndPaketDataListViews extends StatefulWidget {

  final BillProductsResponse response;
  PulsaAndPaketDataListViews({Key key,this.response}) : super(key: key);

  @override
  PulsaAndPaketDataListViewsState createState() => PulsaAndPaketDataListViewsState();

}

class PulsaAndPaketDataListViewsState extends BaseState<PulsaAndPaketDataListViews>with SingleTickerProviderStateMixin {
  BillController controller = Get.find<BillController>();

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
          length: 2,
          child:  Scaffold(
            appBar:  PreferredSize(
              preferredSize: Size.fromHeight(96.0),
              child:  SafeArea(
                child: Container(
                  child:appBarTitleWidget(),
                ),
              ),
            ),
            body:  TabBarView(
              children: [

                commonListView(getPulsaAndPaketData("Pulsa")),
                commonListView(getPulsaAndPaketData("Paket Data")),
                 ],
              )
          ),
        );
    }

  @override
  BuildContext getContext() {
    return context;
  }

 Widget appBarTitleWidget() {
    return Container(
      decoration: getDecoration(),
      height: 96,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              height: 56,
              child: Row(
                children: [
                  backArrowIcon(),
                  titleWidget(),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            child: TabBar(
                labelStyle: TextStyles.otpWithSMSTextStyle,
                unselectedLabelStyle: TextStyles.pulsaUnSelectedTextStyle,
                indicator: CustomTabIndicator(color:AppColors. color_black_100_2_2_2),

              tabs: [ // Pulsa
                Container(
                  alignment:Alignment.topCenter,
                  child: Text(
                      getTranslation(Strings.pulsa),
                      textAlign: TextAlign.center
                  ),
                ),  // Paket Data
                Container(
                  alignment:Alignment.topCenter,
                  child: Text(
                      getTranslation(Strings.paketdata),
                      textAlign: TextAlign.center
                  ),
                )],
            ),
          )
        ],

      ),
    );
 }

  Widget backArrowIcon() {
    return Container(
      margin: EdgeInsets.only(left:16,right: 12),
      child: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
          width: 24.0,
          height: 24.0),
    ).onTap(onPressed: (){
      pop();
    });
  }

  Widget titleWidget() {
    return Text( getTranslation(Strings.pulsaandpaketdata),
      style: BaseStyles.topBarTextStyle,
    );

  }

  Widget commonListView(List<BillProductDataBean> pulsaOrPaketData) {
    return
      ListView.builder(
        itemCount: pulsaOrPaketData.length,
        itemBuilder: (context,index){
          return Column(
            children: [
              ListTile(
                onTap: ()async{
                  List<BillProductDataBean> data = controller.getProducts(pulsaOrPaketData[index]);
                  Get.to(CommonBillsProductsListView(data:data));
                },
                leading: Image.asset("assets/images/avatar-11.png",height: 32,width: 32),
                title: Text(pulsaOrPaketData[index].biller),
                trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],size: 24,),
              ),
              Divider()
            ],
          );
        },

      );
  }


 BoxDecoration getDecoration() {
  return  BoxDecoration(
     boxShadow: [BoxShadow(
         color: AppColors.billerPaymentNextButtonColor,
         offset: Offset(0,1),
         blurRadius: 0,
         spreadRadius: 0
     )] ,
     color: AppColors.primaryElement,);
 }



  List<BillProductDataBean> getPulsaAndPaketData(String category) {
    return BillerHelper().getBillersByCategory(widget.response, category);
  }




}
class CustomTabIndicator extends Decoration {
  final BoxPainter _painter;

  CustomTabIndicator({@required Color color,})
      : _painter = BorderPainter(color);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class BorderPainter extends BoxPainter {
  final Paint _paint;

  BorderPainter(Color color)
      : _paint = Paint()..color = color..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Rect rect = Offset(offset.dx,(configuration.size.height - 6 ?? 3)) & Size(configuration.size.width, 6?? 3);
    canvas.drawRRect(RRect.fromRectAndCorners(rect,topRight: Radius.circular(100), topLeft: Radius.circular(100)),_paint);

  }
}