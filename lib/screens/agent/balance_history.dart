import 'package:flutter/material.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/Data.dart';

class BalanceHistory extends StatefulWidget {
  final int selectedIndex;
  final String fromScreen;
  BalanceHistory({Key key, this.selectedIndex, this.fromScreen = ""}) : super(key: key);

  @override
  _BalanceHistoryState createState() => _BalanceHistoryState();
}

class _BalanceHistoryState extends BaseState<BalanceHistory> {

  List<BalanceHistoryInfo> arrCollectionItems = [];
  List<BalanceHistoryInfo> arrPayoutItems = [];

  List<BalanceInfo> arrSeptemberItems = [];
  List<BalanceInfo> arrAugustItems = [];
  List<BalanceInfo> arrJulyItems = [];
  List<BalanceInfo> arrRecentItems = [];

  List<String> arrPayoutHeaderTitles = ["September", "August","July"];
  List<String> arrSeptemberDateMonthTitles = ["12 Sep, 16:21", "10 Sep, 16:21","9 Sep, 16:21", "6 Sep, 16:21"];
  List<String> arrAugustDateMonthsTitles = ["30 Aug, 16:21",];
  List<String> arrJulyDateMonthsTitles = ["28 Jul, 16:21", "15 Jul, 16:21",];

  List<String> arrSeptemberAmounts = ["Rp 500.000", "Rp 750.000","Rp 800.000", "Rp 1.000.000"];
  List<String> arrSeptemberPersonNames = ["Yakub Pasha Shaik", "Kiran","Harish","George"];
  List<String> arrAugustAmounts = ["Rp 500.000",];
  List<String> arrJulyAmounts = ["Rp 1.500.000", "Rp 200.000",];

  List<String> arrCollectionHeaderTitles = ["Recent","September",];
  List<String> arrRecentDateMonthTitles = ["Today, 16:21", "Today, 16:21","Today, 16:21",];
  List<bool> arrRecentContacts = [true,false,true];
  List<String> arrRecentAmount = ["Rp 500.000", "Rp 500.000","Rp 500.000",];
  List<String> arrRecentPersonNames = ["Yakub Pasha Shaik", "Kiran","Harish",];

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData()
  {
    arrSeptemberItems = [];
    for (var i = 0; i < arrSeptemberDateMonthTitles.length; i++) {
      var balanceInfo = BalanceInfo();
      balanceInfo.dateTime = arrSeptemberDateMonthTitles[i];
      balanceInfo.amount = arrSeptemberAmounts[i];
      balanceInfo.personName = arrSeptemberPersonNames[i];
      arrSeptemberItems.add(balanceInfo);
    }

    arrAugustItems = [];
    for (var i = 0; i < arrAugustDateMonthsTitles.length; i++) {
      var balanceInfo = BalanceInfo();
      balanceInfo.dateTime = arrAugustDateMonthsTitles[i];
      balanceInfo.amount = arrAugustAmounts[i];
      arrAugustItems.add(balanceInfo);
    }

    arrJulyItems = [];
    for (var i = 0; i < arrJulyDateMonthsTitles.length; i++) {
      var balanceInfo = BalanceInfo();
      balanceInfo.dateTime = arrJulyDateMonthsTitles[i];
      balanceInfo.amount = arrJulyAmounts[i];
      arrJulyItems.add(balanceInfo);
    }

    //Payout Items Related
    List<List<BalanceInfo>> monthWiseBalanceHistoryInPayout = [arrSeptemberItems,arrAugustItems,arrJulyItems];
    arrPayoutItems = [];
    for (var i = 0; i < arrPayoutHeaderTitles.length; i++) {
      var balanceHistoryInfo = BalanceHistoryInfo();
      balanceHistoryInfo.monthName = arrPayoutHeaderTitles[i];
      balanceHistoryInfo.balanceHistory = monthWiseBalanceHistoryInPayout[i];
      arrPayoutItems.add(balanceHistoryInfo);
    }

    //Collection Items Related
    arrRecentItems = [];
    for (var i = 0; i < arrRecentDateMonthTitles.length; i++) {
      var balanceInfo = BalanceInfo();
      balanceInfo.dateTime = arrRecentDateMonthTitles[i];
      balanceInfo.amount = arrRecentAmount[i];
      balanceInfo.personName = arrRecentPersonNames[i];
      balanceInfo.isTaraContact = arrRecentContacts[i];
      arrRecentItems.add(balanceInfo);
    }

    List<List<BalanceInfo>> monthWiseBalanceHistoryInCollection = [arrRecentItems,arrSeptemberItems,];
    arrCollectionItems = [];
    for (var i = 0; i < arrCollectionHeaderTitles.length; i++) {
      var balanceHistoryInfo = BalanceHistoryInfo();
      balanceHistoryInfo.monthName = arrCollectionHeaderTitles[i];
      balanceHistoryInfo.balanceHistory = monthWiseBalanceHistoryInCollection[i];
      arrCollectionItems.add(balanceHistoryInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      initialIndex: (widget.selectedIndex!=null)?widget.selectedIndex:0,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context),
          body: TabBarView(
            children: [
              getBalanceHistoryWidget(Strings.collection),
              getBalanceHistoryWidget(Strings.payout),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
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
            getTranslation(Strings.balance_history),
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
                    getTab(widget.fromScreen == "merchant" ? Strings.incoming : Strings.collection),
                    getTab(widget.fromScreen == "merchant" ? Strings.outgoing : Strings.payout),
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

  getBalanceHistoryWidget(String tabTitle)
  {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: MediaQuery.of(context).size.height,
      child: SectionTableView(
        sectionCount:(
            tabTitle==Strings.collection?arrCollectionItems.length:arrPayoutItems.length
        ),
        numOfRowInSection: (section) {
          return tabTitle==Strings.collection?arrCollectionItems[section].balanceHistory.length:arrPayoutItems[section].balanceHistory.length;
        },
        cellAtIndexPath: (section, row) {
          return tabTitle==Strings.collection?geBalanceInfoItemWidget(arrCollectionItems[section].balanceHistory[row],tabTitle):geBalanceInfoItemWidget(arrPayoutItems[section].balanceHistory[row],tabTitle);
        },
        headerInSection: (section) {
          return tabTitle==Strings.collection?headerViewContainer(arrCollectionItems[section].monthName):headerViewContainer(arrPayoutItems[section].monthName);
        },
      ),
    );
  }

  Widget headerViewContainer(String headerTitle) {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 8,top: 12,bottom: 12),
      child: Text(
          headerTitle,
          style: TextStyles.subtitle2222
      ),
    );
  }

  Widget geBalanceInfoItemWidget(BalanceInfo balanceInfo,String tabTitle) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide( //                   <--- left side
                  color: Color(0xffe9ecef),
                  width: 0.5,
                ),
                bottom: BorderSide( //                    <--- top side
                  color: Color(0xffe9ecef),
                  width: 0.3,
                ),
              )
            ),
          child: Center(
            child:
            Row(
              children: [
                tabTitle==Strings.payout?Container(
                    margin: EdgeInsets.only(left: 10,),
                    child:Container(
                    width: 36,
                    height: 36,
                    decoration: new BoxDecoration(
                      color: Color(0xff123456),
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        Assets.RECEIVE_ICON,
                        height: 24,
                        width: 24,
                      ),
                    ))):(balanceInfo.isTaraContact!=null&&balanceInfo.isTaraContact)?Container(
                  margin: EdgeInsets.only(left: 10,),
                  child: Image.asset(
                    "assets/images/avatar-11.png",
                    height: 32,
                    width: 32,
                  ),
                ):Container(
            margin: EdgeInsets.only(left: 10,),
            child:bigCircle(balanceInfo.personName)),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          balanceInfo.dateTime,
                          textAlign: TextAlign.left,
                          style: BaseStyles.itemOrderQuantityTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: tabTitle==Strings.collection?Text(
                          balanceInfo.amount,
                          textAlign: TextAlign.left,
                          style: BaseStyles.backAccountHeaderTextStyle,
                        ):RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      style: TextStyles.payoutMinusTextTtyle,
                                      text: "- "),
                                  TextSpan(
                                      style: TextStyles.subtitle1222,
                                      text: balanceInfo.amount)
                                ]
                            )
                        ),
                      ),
                      tabTitle==Strings.collection?Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          balanceInfo.personName,
                          textAlign: TextAlign.left,
                          style: BaseStyles.saveToMyContactTextStyle,
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {

        }
    );
  }

  Widget bigCircle(String name) {
    return Container(
        width: 36,
        height: 36,
        decoration: new BoxDecoration(
          color: Color(0xff123456),
          shape: BoxShape.circle,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name.length > 0 ? name.substring(0, 1).toUpperCase() : "",
              style: BaseStyles.contactsTextStyle, textAlign: TextAlign.center),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}