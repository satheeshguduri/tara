import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/constants/radii.dart';
import 'package:tara_app/common/constants/shadows.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/enums.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/order_management/orders/order_items.dart';
import 'package:tara_app/models/order_management/orders/statuses.dart';
import 'package:tara_app/repositories/auth_repository.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/services/error/failure.dart';

import '../../injector.dart';

class SeeAllOrdersScreen extends StatefulWidget {

  SeeAllOrdersScreen({Key key,}) : super(key: key);

  @override
  _SeeAllOrdersScreenState createState() => _SeeAllOrdersScreenState();
}

class _SeeAllOrdersScreenState extends BaseState<SeeAllOrdersScreen> {

  List<order.Order> filteredList = [];
  bool isTapOnIndex1 = true;
  bool isTapOnIndex2 = false;
  bool isTapOnIndex3 = false;

  OrderController controller = Get.find();

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void init() {
    // TODO: implement init
    super.init();
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

  }
  Widget getNameFuture(customerId) {
    return FutureBuilder(
        future: getIt.get<AuthRepository>().getCustomerInfoByCustomerId(customerId.toString()),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            if (snapshot.hasData) {
              Either<Failure, CustomerProfile> customerProfile = snapshot.data;
              var name = "";
              customerProfile.fold((l) => Get.defaultDialog(content: Text(l.message)), (
                  r) => name= r.firstName);
              return Text(

                  name??"-", //TODO:- Display Name Here
                  style: const TextStyle(
                      color:  AppColors.primaryText,
                      fontWeight: FontWeight.w700,
                      
                      fontSize: 14.0
                  )
              );
            }
            return Container();
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: BaseWidgets.getListIndicator);
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context),
          body: TabBarView(
            children: [
              getAllOrdersWidget(),
              getAllOrdersWidget()
            ],
          ),
        ),
      ),
    );
  }

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
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
              ),
              Flexible(child: getBottomView(),fit: FlexFit.loose,)
            ],
          ),
        )
    );
  }

  Widget getBottomView(){
    if(isTapOnIndex1){
      filteredList = controller.orderList.where((order) => order.status == Statuses.PENDING).toList();
    }else if(isTapOnIndex2){
      filteredList = controller.orderList.where((order) => order.status == Statuses.ACCEPTED).toList();
    }else if(isTapOnIndex3){
      filteredList = controller.orderList.where((order) => order.status == Statuses.DELIVERED).toList();
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
                                    
                                    fontSize: 10.0
                                )
                            ),
                            Container(height: 6,),
                            getNameFuture(filteredList[index].customerId),
                            Container(height: 6,),
                            Text(
                                getOrderItems(filteredList[index]),
                                style: const TextStyle(
                                    color:  AppColors.battleship_grey,
                                    fontWeight: FontWeight.w400,
                                    
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
                                    
                                    fontSize: 14.0
                                ),
                                text: "+ "),
                            TextSpan(
                                style: const TextStyle(
                                    color:  AppColors.fareColor,
                                    fontWeight: FontWeight.w400,
                                    
                                    fontSize: 14.0
                                ),
                                text: "Rp " + controller.orderList[index].price.toString())
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

  _buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0.6,
        centerTitle: false,
        automaticallyImplyLeading: false, // hides leading widget
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pop(context, false) //Navigator.pop(context, false),
        ),
        title:Align(
          alignment: Alignment.topLeft,
          child: Text(
            getTranslation(Strings.ORDERS),
            textAlign: TextAlign.left,
            style: BaseStyles.topBarTextStyle,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 1.5,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: TabBar(
                  isScrollable: false,
                  unselectedLabelColor: Color(0xff889aac),
                  indicatorColor: AppColors.header_top_bar_color,
                  labelColor: AppColors.header_top_bar_color,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 4.0,
                  tabs: [
                    getTab(Strings.customers),
                    getTab(Strings.suppliers),
                  ],
                  labelStyle: BaseStyles.chatInboxTabSelectedTextColor,
                  unselectedLabelStyle:BaseStyles.chatInboxTabUnSelectedTextColor
              ),
            ),
          ),
        )
    );
  }


  getTab(String tabName)
  {
    return Container(
      margin: EdgeInsets.only(top: 16,bottom: 8,),
      child: Text(
          getTranslation(tabName),
          textAlign: TextAlign.center
      ),
    );
  }
  String getOrderItems(order.Order orderTemp){
    var itemsStr = "";
    for(OrderItems item in orderTemp.items){
      itemsStr += item.name + ",";
    }
    return itemsStr.substring(0, itemsStr.length - 1);
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

  @override
  void dispose() {
    super.dispose();
  }
}