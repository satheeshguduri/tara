
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
                  ListTile(
                    leading: Image.asset("assets/images/avatar-11.png",height: 32,width: 32),
                    title: Text(widget.data[index].name),
                    subtitle: Text(widget.data[index].description),
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
          widget.data[0].biller,
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );

  }

}