
import 'package:flutter/material.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import '../../common/constants/values.dart';


class CommonBillsProductsListView extends StatefulWidget {
  final List<BillProductDataBean> data;
  CommonBillsProductsListView({Key key,this.data}) : super(key: key);

  @override
  CommonBillsProductsListViewState createState() => CommonBillsProductsListViewState();

}

class CommonBillsProductsListViewState extends BaseState<CommonBillsProductsListView>{


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
                  // ListTile(
                  //   leading: Image.asset("assets/images/avatar-11.png",height: 32,width: 32),
                  //   title: Text(widget.data[index].name),
                  //   subtitle: Text(widget.data[index].description),
                  //   trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],size: 24,),
                  //
                  // ),
                  customListTile(index),
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
          widget.data[0].biller,
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );

  }

 Widget customListTile(int index) {
 return Container(
   height: 104,
   child: Row(children: [
     Expanded(flex: 6,child: leftSideWidgets(index)),
     Expanded(flex:4,child:rightSideWidget(index))

   ],)
 );

 }
  Widget leftSideWidgets(int index) {
    return Container(
      margin: EdgeInsets.only(left: 16,top: 16),
      child: Column(
        children: [Container(
                    margin: EdgeInsets.only(right: 16,bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.data[index].name,
                          style: TextStyles.subtitle1222,)),
                   Container(
                       margin: EdgeInsets.only(bottom: 8),
                       alignment: Alignment.centerLeft,
                    child: Text("4.5 GB + 2 GB Video",
                        style:TextStyles.caption222,

                    )
                   ),
                   Container(
                       alignment: Alignment.centerLeft,
                       child: Text(widget.data[index].description,
                            style: TextStyles.productsListDescTextStyle))]

      ),
    );
  }
 Widget rightSideWidget(int index) {
    return // Container
      Container(
          alignment: Alignment.center,
          width: 88,
          height: 24,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(6)
              ),
              color: AppColors.productListPriceColor
          ),
          child: Text(
              widget.data[index].amount.toString(),
          style: TextStyles.bUTTONSmallBlack222,
          textAlign: TextAlign.center
      ),
      );

  }



}