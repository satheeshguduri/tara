
import 'package:flutter/material.dart';
import 'package:tara_app/screens/base/base_state.dart';
import '../../common/constants/values.dart';


class CommonBillsPaymentListView extends StatefulWidget {
  String title;
  CommonBillsPaymentListView({Key key,this.title}) : super(key: key);

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
            itemCount: 5,
            itemBuilder: (context,index){
              return Column(
                children: [
               ListTile(
              leading: Image.asset("assets/images/avatar-11.png",height: 32,width: 32),
              title: Text("hello"),
              trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],size: 24,),

                ),
                  Divider()
             ],
           );


            },
      //         separatorBuilder:(context,index){
      //         return Divider();
      // }
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
            widget.title,
            textAlign: TextAlign.left,
            style: BaseStyles.topBarTextStyle,
          ),
        ),
      );

  }

}