import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/controller/order_controller.dart';

import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/services/error/failure.dart';



class CustomerOrdersScreen extends StatefulWidget {
  @override
  CustomerOrdersScreenState createState() => CustomerOrdersScreenState();
}

class CustomerOrdersScreenState extends BaseState<CustomerOrdersScreen> {
  List<order.Order> orderList = [],filteredList=[];
  bool isTapOnIndex1 = true;
  bool isTapOnIndex2 = false;
  bool isTapOnIndex3 = false;
  AuthResponse user = Get.find<AuthResponse>();

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(child: getAllOrdersWidget()),
      );
  }
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.ORDERS),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }
 Widget  getOrdersFuture() {
   return FutureBuilder(
       future: getIt.get<OrderRepository>().getOrdersByConsumerId(user.customerProfile.id),
       builder: (context, AsyncSnapshot snapshot) {
         if (snapshot.connectionState == ConnectionState.done) {
           // If the Future is complete, display the preview.
           if (snapshot.hasData) {
             Either<Failure, List<order.Order>> orders = snapshot.data;
             orders.fold((l) => Get.defaultDialog(content: Text(l.message)), (
                 r) => orderList = r);
             return getBottomView();
           }
           return Container();
         } else {
           // Otherwise, display a loading indicator.
           return const Center(child: BaseWidgets.getIndicator);
         }
       }
     );
  }


  @override
  BuildContext getContext() => context;

  Widget getAllOrdersWidget()
  {
    return Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child:SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tabsRow(),
              getOrdersFuture()
              // getAllOrdersWidget()
              // Flexible(child: ,fit: FlexFit.loose,)
            ],
          ),
        )
    );
  }

  BoxDecoration roundedBoxDecoration(){
    return BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(20)
        ),
        boxShadow: Shadows.shadows_list ,
        color: AppColors.primaryBackground
    );
  }

  Widget getBottomView(){

    if(isTapOnIndex1){
      filteredList = orderList.where((order) => order.status == Statuses.PENDING).toList();
    }else if(isTapOnIndex2){
      filteredList = orderList.where((order) => order.status == Statuses.ACCEPTED).toList();
    }else if(isTapOnIndex3){
      filteredList = orderList.where((order) => order.status == Statuses.DELIVERED).toList();
    }
    // New
    if(filteredList.isNotEmpty){

      return Container(
        margin: EdgeInsets.only(bottom: 32),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredList.length,
          itemBuilder: (context,index){
            return Align(
                alignment:Alignment.topCenter,
                child: Container(
                  //color:Colors.green,
                  child: getOrderCard(index),
                )
            );
          },
        ),
      );
    }
    return Container();
  }

  Widget getOrderCard(int index) {
    return Container(
      //color:Colors.blue,
      padding: EdgeInsets.only(left:16,right:16,top:8,bottom: 8),
      decoration:BoxDecoration(
        border: Border(
          bottom: BorderSide( //                   <--- left side
            color: Colors.grey[300],
            width: 0.5,
          ),
        ),
      ),
      child:Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Rectangle
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(Assets.ic_person1,height: 40,width: 40,),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TODAY • 12:33
                            Text(
                                DateFormat('dd MMM yyyy • kk:mm').format(filteredList[index].orderDate),
                                    style: const TextStyle(
                                    color:  AppColors.color_black_80_2,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 10.0
                                )
                            ),
                            Container(height: 6,),
                            Text(
                                filteredList[index].storeId.name,
                              // TODO:- Display Name Here
                                   style: const TextStyle(
                                    color:  AppColors.primaryText,
                                    fontWeight: FontWeight.w700,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 14.0
                                )
                            ),
                            Container(height: 6,),
                            Text(
                                getOrderItems(filteredList[index]),
                                    style: const TextStyle(
                                    color:  AppColors.battleship_grey,
                                    fontWeight: FontWeight.w400,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 12.0
                                )
                            )
                          ],
                        ) ,
                      ),
                    ]),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 0),
                  child:  RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                style: const TextStyle(
                                    color:  AppColors.pale_turquoise,
                                    fontWeight: FontWeight.w700,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 14.0
                                ),
                                text: "+ "),
                            TextSpan(
                                style: const TextStyle(
                                    color:  AppColors.fareColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 14.0
                                ),
                                text: "Rp " + filteredList[index].price.toString())

                          ]
                      )
                  ),
                )
              ],
            ),
          ),
        ],
      )
      ,
    ).onTap(onPressed: (){
      if(filteredList[index]?.order_extra?.data?.customer_commid?.isNotEmpty??false){
        var firID = filteredList[index].order_extra.data.customer_commid;
        var customer = CustomerProfile();
        customer.firebaseId = firID;
        customer.firstName = "Customer Name";
        push(ConversationPage(arrChats: ["items_order"],custInfo: customer, fromScreen: FromScreen.merchant,));
      }else{
        showToast(message: "Unable to show the order");//translate the message.
      }
    });
  }

  String getOrderItems(order.Order orderTemp){
    var itemsStr = "";
    for(OrderItems item in orderTemp.items){
      itemsStr += item.name + ",";
    }
    return itemsStr.substring(0, itemsStr.length - 1);
  }

  Widget tabsRow() {
  return Container(
      padding: EdgeInsets.only(top:8,bottom: 8),
      decoration:BoxDecoration(
        border: Border(
          bottom: BorderSide( //                   <--- left side
            color: Colors.grey[300],
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16,top: 8,bottom: 8),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: Radii.border(24),
            color: const Color(0xfff7f7f7)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  isTapOnIndex1 = true;
                  isTapOnIndex2 = false;
                  isTapOnIndex3 = false;
                });
              },
              child: Container(
                  width: 104,
                  height: 40,
                  decoration: isTapOnIndex1 ? roundedBoxDecoration() : null,
                  child:Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            getTranslation(Strings.NEW),
                            style: const TextStyle(
                                color:  AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontStyle:  FontStyle.normal,
                                fontSize: 14.0
                            ),
                            textAlign: TextAlign.center
                        ),
                        Visibility(
                          visible: filteredList.isNotEmpty,
                          child: Container(
                            margin: EdgeInsets.only(left: 4),
                            alignment: Alignment.center,
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                color: AppColors.badge_color,
                                borderRadius:Radii.border(8)
                            ),
                            child: Text(
                                "${filteredList.length}",
                                style: const TextStyle(
                                    color:  const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 10.0
                                ),
                                textAlign: TextAlign.center
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ) ,
            ),
            InkWell(
              onTap: (){
                setState(() {
                  isTapOnIndex1 = false;
                  isTapOnIndex2 = true;
                  isTapOnIndex3 = false;
                });
              },
              child:Container(
                  width: 104,
                  height: 40,
                  decoration: isTapOnIndex2 ? roundedBoxDecoration() : null,
                  child:Center(
                    child: Text(
                        getTranslation(Strings.IN_PROGRESS),
                        style: const TextStyle(
                            color:  AppColors.primaryText,
                            fontWeight: FontWeight.w500,
                            fontStyle:  FontStyle.normal,
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.center
                    ),
                  )
              ) ,
            ),
            InkWell(
              onTap: (){
                setState(() {
                  isTapOnIndex1 = false;
                  isTapOnIndex2 = false;
                  isTapOnIndex3 = true;
                });
              },
              child:Container(
                  width: 104,
                  height: 40,
                  decoration: isTapOnIndex3 ? roundedBoxDecoration() : null,
                  child:Center(
                    child: Text(
                        getTranslation(Strings.COMPLETED),
                        style: const TextStyle(
                            color:  AppColors.primaryText,
                            fontWeight: FontWeight.w500,
                            fontStyle:  FontStyle.normal,
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.center
                    ),
                  )
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}