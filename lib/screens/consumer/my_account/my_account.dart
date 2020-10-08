

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/card_view.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/my_account/connect_new_account_select_ank.dart';
import 'package:tara_app/screens/consumer/enter_mpin.dart';
import 'package:tara_app/screens/consumer/my_account/enter_mpin_screen.dart';

class MyAccount extends StatefulWidget{

  final String fromScreen;

  const MyAccount({
    Key key,
    this.fromScreen,

  }) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();

}

class _MyAccountState extends BaseState<MyAccount>{

  int _current = 0;
  List<String> cardList = List<String>();

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: (widget.fromScreen!=null&&widget.fromScreen==getTranslation(Strings.MY_ACCOUNTS))?false:true,
      automaticallyImplyLeading: false,
      leading: (widget.fromScreen!=null&&widget.fromScreen==getTranslation(Strings.MY_ACCOUNTS))?IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ):Container(width: 1,),// hides leading widget
      title:Text(
        getTranslation(Strings.MY_ACCOUNT),
        textAlign: (widget.fromScreen!=null&&widget.fromScreen==getTranslation(Strings.MY_ACCOUNTS))?TextAlign.left:TextAlign.center,
        style: BaseStyles.topBarTextStyle,
      ),
    );
  }

  Widget _loadAccounts() {
    return InkWell(
      child:Column(children: [
        CarouselSlider(
          items: loadCards(),
          options: CarouselOptions(
            // autoPlay: true,
            enableInfiniteScroll: false,
              aspectRatio: 2.3,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: loadCards().map((url) {
            int index = loadCards().indexOf(url);
            return Container(
              width: 6.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.6)
                    : Color.fromRGBO(0, 0, 0, 0.3),
              ),
            );
          }).toList(),
        ),
      ]) ,
      onTap: (){
      },
    );
  }

  List<Widget> loadCards(){
    var newList = List<Widget>();
    newList.add(Container(
      child: CustomCard(
        image:Assets.my_account_card,bankIcon: Assets.ic_tara,
        accountName: "Budi Sudarso",
        accountNumber: getTranslation(Strings.MPIN_ACCOUNT_NUMBER),
        isMyAccountCard: true,
        rightIcon: Assets.ic_right,
      ),
    ));

    if(cardList.length == 0){
      newList.add(
        Container(
          padding: EdgeInsets.all(16),
          child:DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.grey[400],
            strokeWidth:1.5,
            radius: Radius.circular(8),
            child: ClipRRect(
              borderRadius: Radii.border(8.0),
              child: InkWell(
                child: Container(
                  color: AppColors.background_color,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color:AppColors.pale_turquoise,
                            borderRadius: Radii.border(20.0)
                        ),
                        margin: EdgeInsets.only(left: 8),
                        child: Image.asset(Assets.ic_plus,
                          fit: BoxFit.none,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          getTranslation(Strings.connect_new_account),
                          textAlign: TextAlign.left,
                          style: BaseStyles.transaction_account_name_textStytle,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConnectNewAccountSelectBank()),
                  );
                },
              )
              ,
            ),
          ),
        )
        );

    }else{

    }
    return  newList;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.background_color,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              child: _loadAccounts(),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.only(top:16,left: 16,right: 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslation(Strings.ACCOUNT_SETTINGS),
                    style: BaseStyles.topBarTextStyle,
                  ),

                   Container(
                     margin: EdgeInsets.only(top: 8),
                   height: 50,
                   child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslation(Strings.set_as_default_acc),
                        style: BaseStyles.bankNameTextStyle,
                      ),
                      Switch(

                        value: true,
                        activeColor: AppColors.pale_turquoise,
                        onChanged: (value){

                        },
                      )

                    ],
                  ),),

                  Divider(),
                  Container(
                    height: 50,
                    child: InkWell(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslation(Strings.balance_check),
                            style: BaseStyles.bankNameTextStyle,
                          ),
                          Image.asset(Assets.ic_arrow_right)
                        ],
                      ) ,
                      onTap: (){

                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 50,
                    child: InkWell(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslation(Strings.mpin),
                            style: BaseStyles.bankNameTextStyle,
                          ),
                          Image.asset(Assets.ic_arrow_right)
                        ],
                      ) ,
                      onTap: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateMPIN()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 16,bottom: 16),
              padding: EdgeInsets.only(left: 16),
              color: Colors.white,
              child: InkWell(
                child: Text(getTranslation(Strings.delete_account),style: BaseStyles.deleteAccountStyle,),
                onTap: (){

                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

}