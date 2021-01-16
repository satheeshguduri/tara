import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:darq/darq.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends BaseState<TransactionHistory> {
  TextEditingController _searchQuery = TextEditingController();
  String _searchText = "";
  final key = new GlobalKey<ScaffoldState>();

  List<TransactionHistoryInfo> arrAllTransactionItems = [];
  List<TransactionInfo> allTransactionHistory = [];
  List<TransactionInfo> filterTransactionHistory = [];

  List<TransactionInfo> arrRecentItems = [];
  List<TransactionInfo> arrSeptemberItems = [];
  List<TransactionInfo> arrAugustItems = [];
  List<String> arrSectionHeaderTitles = ["Recent", "September", "August"];

  List<String> arrRecentTransactionIds = [
    "TAR2212",
    "TAR3412",
  ];
  List<String> arrRecentDateMonthTitles = [
    "Today, 16:21",
    "Today, 16:21",
  ];
  List<String> arrRecentTransactionDesc = [
    "Bibili Order Number:\n1204061104",
    "Tokopedia Payment",
  ];
  List<String> arrRecentSource = [
    "BANK MANDIRI ****1422",
    "Tara Wallet",
  ];
  List<bool> arrRecentContacts = [false, false];
  List<String> arrRecentAmount = ["Rp 1.350.000", "Rp 213.000"];
  List<bool> arrRecentStatus = [
    true,
    true,
  ];

  List<String> arrSeptTransactionIds = [
    "TAR1212",
    "TAR4222",
    "TAR4221",
  ];
  List<String> arrSeptDateMonthTitles = [
    "08 Sep, 16:21",
    "07 Sep 2020, 16:21",
    "07 Sep 2020, 16:21"
  ];
  List<String> arrSeptTransactionDesc = [
    "Transfer Money to Anisa\nRahmawati",
    "PLN Prepaid 100.000",
    "Tara Wallet Top Up"
  ];
  List<String> arrSeptSource = [
    "BANK BCA ****1422",
    "BANK MANDIRI ****1422",
    "08123456789"
  ];
  List<bool> arrSeptContacts = [true, false, false];
  List<String> arrSeptAmount = ["Rp 100.000", "Rp 100.320", "Rp 100.320"];
  List<bool> arrSeptStatus = [true, false, false];

  List<String> arrAugTransactionIds = [
    "TAR2213",
    "TAR3413",
  ];
  List<String> arrAugDateMonthTitles = [
    "02 Aug, 16:21",
    "02 Aug, 16:21",
  ];
  List<String> arrAugTransactionDesc = [
    "Transfer Money to Anisa\nRahmawati",
    "PLN Prepaid 100.000",
  ];
  List<String> arrAugSource = [
    "BANK BCA ****1422",
    "BANK MANDIRI ****1422",
  ];
  List<bool> arrAugContacts = [
    true,
    false,
  ];
  List<String> arrAugAmount = ["Rp 1.350.000", "Rp 213.000"];
  List<bool> arrAugStatus = [
    true,
    true,
  ];

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    loadData();
    getTransactionsFuture();
  }
  Widget  getTransactionsFuture() {
    return FutureBuilder(
      future: Get.find<TransactionController>().getTransactions(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          if(snapshot.connectionState == ConnectionState.done) {
            TransactionHistoryResponse data = snapshot.data;
            var transactionsListTemp = data.transactionList;
            var months = transactionsListTemp.distinct((d) => d.month).toList();
            var sectionRows = <List<TransactionListBean>>[];
            months.forEach((element) {
              var list = transactionsListTemp.where((e) =>
              e.month == element.month).toList();
              sectionRows.add(list);
            });
            return getTransactionListWidget(months, sectionRows);
          }else if(snapshot.hasError){
            return ErrorStateInfoWidget(title: "No Transaction History Yet",
              desc: "You have not made any transaction yet. Your transactions including transfers, requests and payments will be listed here",
              image: getSvgImage(imagePath:Assets.assets_icon_no_trans,width: 192.0,height:192.0),); //TODO String to json file}
          }

          // print(months.toString());


        }
        return BaseWidgets.getIndicator;
      },
    );
  }

  Container getTransactionListWidget(List<TransactionListBean> months, List<List<TransactionListBean>> sectionRows) {
    return Container(
          margin: EdgeInsets.only(bottom:16),
          child: SectionTableView(
            sectionCount:months.length,
            // ((!(_searchText?.isNotEmpty??false)) ? months.length : (_searchText.isNotEmpty && filterTransactionHistory.isEmpty) ? 1 : 1),
            //for recent search, popular search and user search
            numOfRowInSection: (section) {
            return sectionRows[section].length;
             /* if (_searchText.isNotEmpty && filterTransactionHistory.isEmpty) {
                return 0;
              } else {
                return sectionRows[section].length;*/
                /*var count = transactionsListTemp.where((d)=>d.month == months[section].month).toList()?.length;
                return count;*/
                // return arrAllTransactionItems[section].transactionHistory.length;
                //default state when search not applied
               /* if (!(_searchText != null && _searchText.toString().isNotEmpty)) {

                  return arrAllTransactionItems[section].transactionHistory.length;
                }*/
                //search applied
               /* else {
                  return filterTransactionHistory.length;
                }*/
              // }
            },

            cellAtIndexPath: (section, row) {
              return geTransactionInfoItemWidget(sectionRows[section][row],row);
              /*if (_searchText.toString().isNotEmpty &&
                  filterTransactionHistory.isEmpty) {
                return Container();
              } else {
                // return Container();
                //TODO: need to uncomment the whole code once the changes done!!
                 if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
                   transactionsListTemp.where((d)=>d.month == months[section].month).toList()?.length;
              return geTransactionInfoItemWidget(sectionRows[section][row],row);
                  // transactionsListTemp[section].transactionHistory[row],row);
            }
            //search applied
            else {
              return geTransactionInfoItemWidget(filterTransactionHistory[row],row);
            }
              }*/
            },

            headerInSection: (section) {
              return headerViewContainerWithSection(months[section].month);
              /*if (_searchText.toString().isNotEmpty &&
                  filterTransactionHistory.isEmpty) {
                return headerViewContainer();
              } else {
                if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
                  return headerViewContainerWithSection(months[section].month);
                }
                //search applied
                else {
                  return headerViewContainer();
                  ;
                }
              }*/
            },
          ),
        );
  }
  loadData() {
    allTransactionHistory = [];
    arrRecentItems = [];
    for (var i = 0; i < arrRecentTransactionIds.length; i++) {
      var transactionInfo = TransactionInfo();
      transactionInfo.dateTime = arrRecentDateMonthTitles[i];
      transactionInfo.amount = arrRecentAmount[i];
      transactionInfo.transactionId = arrRecentTransactionIds[i];
      transactionInfo.transactionDesc = arrRecentTransactionDesc[i];
      transactionInfo.isTaraContact = arrRecentContacts[i];
      transactionInfo.isSuccess = arrRecentStatus[i];
      transactionInfo.source = arrRecentSource[i];
      arrRecentItems.add(transactionInfo);
      allTransactionHistory.add(transactionInfo);
    }

    arrSeptemberItems = [];
    for (var i = 0; i < arrSeptTransactionIds.length; i++) {
      var transactionInfo = TransactionInfo();
      transactionInfo.dateTime = arrSeptDateMonthTitles[i];
      transactionInfo.amount = arrSeptAmount[i];
      transactionInfo.transactionId = arrSeptTransactionIds[i];
      transactionInfo.transactionDesc = arrSeptTransactionDesc[i];
      transactionInfo.isTaraContact = arrSeptContacts[i];
      transactionInfo.isSuccess = arrSeptStatus[i];
      transactionInfo.source = arrSeptSource[i];
      arrSeptemberItems.add(transactionInfo);
      allTransactionHistory.add(transactionInfo);
    }

    arrAugustItems = [];
    for (var i = 0; i < arrAugTransactionIds.length; i++) {
      var transactionInfo = TransactionInfo();
      transactionInfo.dateTime = arrAugDateMonthTitles[i];
      transactionInfo.amount = arrAugAmount[i];
      transactionInfo.transactionId = arrAugTransactionIds[i];
      transactionInfo.transactionDesc = arrAugTransactionDesc[i];
      transactionInfo.isTaraContact = arrAugContacts[i];
      transactionInfo.isSuccess = arrAugStatus[i];
      transactionInfo.source = arrAugSource[i];
      arrAugustItems.add(transactionInfo);
      allTransactionHistory.add(transactionInfo);
    }

    List<List<TransactionInfo>> monthWiseTransactionHistory = [
      arrRecentItems,
      arrSeptemberItems,
      arrAugustItems
    ];
    arrAllTransactionItems = [];
    for (var i = 0; i < arrSectionHeaderTitles.length; i++) {
      var balanceHistoryInfo = TransactionHistoryInfo();
      balanceHistoryInfo.monthName = arrSectionHeaderTitles[i];
      balanceHistoryInfo.transactionHistory = monthWiseTransactionHistory[i];
      arrAllTransactionItems.add(balanceHistoryInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: getTransactionsFuture(),
        // body: listViewContainer(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false)),
        title: Text(
          getTranslation(Strings.transaction_history),
          style: BaseStyles.topBarTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            padding: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 0.6,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: getSearchBarWidget(),
          ),
        ));
  }

  Widget headerViewContainer() {
    return (_searchText.toString().isNotEmpty && filterTransactionHistory.isEmpty)
        ? Container(
      child: Center(
        child: errorTitleTextWidget(),
      ),
    )
        : Container();
  }

  Widget headerViewContainerWithSection(String monthName) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12),
      child: Text(
        monthName,
        style: TextStyles.subtitle2222,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget errorTitleTextWidget() {
    return Container(
      margin: EdgeInsets.only(
        top: 16,
      ),
      child: Text(
        getTranslation(Strings.we_cannot_find_anything) +
            "\"${_searchText.toString()}\"",
        style: BaseStyles.cannotFindTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getSearchBarWidget() {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 16, right: 16, ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: (_searchText.toString().isNotEmpty)
                    ? AppColors.header_top_bar_color
                    : Colors.grey[400],
                width: 1),
          ),
          child: TextField(
            controller: _searchQuery,
            keyboardType: TextInputType.text,
            style: BaseStyles.baseTextStyle,
            cursorColor: AppColors.header_top_bar_color,
            autofocus: false,
            onChanged: (value) {
              _searchText = value;
              if (_searchText != null &&
                  _searchText.toString().trim().isNotEmpty &&
                  _searchText.toString().trim().length > 2) {
                filterTransactionHistory = List();
                if (allTransactionHistory.length > 0) {
                  filterTransactionHistory = allTransactionHistory
                      .where((transactionInfo) =>
                          (transactionInfo.transactionDesc)
                              .toLowerCase()
                              .contains(_searchText.toLowerCase()))
                      .toList();
                  setState(() {});
                }
              } else {
                if (_searchQuery.text == "") {
                  setState(() {
                    _searchText = "";
                    _searchQuery.text = "";
                    filterTransactionHistory.clear();
                  });
                }
              }
            },
            decoration: new InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
                size: 20,
              ),
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 0.1)),
              hintText: getTranslation(Strings.search_transaction),
              hintStyle: BaseStyles.hintTextStyle,
              focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.transparent)),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear,
                    color: (_searchText != null &&
                            _searchText.toString().isNotEmpty &&
                            _searchText.toString().length > 0)
                        ? Colors.black54
                        : Colors.transparent),
                onPressed: () {
                  setState(() {
                    _searchText = "";
                    _searchQuery.text = "";
                    filterTransactionHistory.clear();
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /*Widget listViewContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: SectionTableView(
        sectionCount:
            ((!(_searchText != null && _searchText.toString().isNotEmpty))
                ? arrAllTransactionItems.length
                : (_searchText.toString().isNotEmpty &&
                        filterTransactionHistory.isEmpty)
                    ? 1
                    : 1),
        //for recent search, popular search and user search
        numOfRowInSection: (section) {
          if (_searchText.toString().isNotEmpty &&
              filterTransactionHistory.isEmpty) {
            return 0;
          } else {
            //default state when search not applied
            if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
              return arrAllTransactionItems[section].transactionHistory.length;
            }
            //search applied
            else {
              return filterTransactionHistory.length;
            }
          }
        },

        cellAtIndexPath: (section, row) {
          if (_searchText.toString().isNotEmpty &&
              filterTransactionHistory.isEmpty) {
            return Container();
          } else {
            return Container();
            //TODO: need to uncomment the whole code once the changes done!!
            geTransactionInfoItemWidget()
           *//* if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
              return geTransactionInfoItemWidget(
                  arrAllTransactionItems[section].transactionHistory[row],row);
            }
            //search applied
            else {
              return geTransactionInfoItemWidget(filterTransactionHistory[row],row);
            }*//*
          }
        },

        headerInSection: (section) {
          if (_searchText.toString().isNotEmpty &&
              filterTransactionHistory.isEmpty) {
            return headerViewContainer();
          } else {
            if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
              return headerViewContainerWithSection(section);
            }
            //search applied
            else {
              return headerViewContainer();
              ;
            }
          }
        },
      ),
    );
  }*/

  geTransactionInfoItemWidget(TransactionListBean transactionInfo,int row) {
    return InkWell(
        child: Stack(children: [
          Container(
              padding: EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  //                   <--- left side
                  color: Color(0xffe9ecef),
                  width: row!=0?0:0.5,
                ),
                bottom: BorderSide(
                  //                    <--- top side
                  color: Color(0xffe9ecef),
                  width: row==0?0:0.5,
                ),
              )),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 7.toInt(),
                      child: Row(
                        children: [
                          // (transactionInfo.isTaraContact != null &&
                          //     transactionInfo.isTaraContact)
                          (transactionInfo.counterpartMobile != null &&
                              transactionInfo.success)//TODO  --- to check if tara user or not
                              ? Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Image.asset(
                              "assets/images/avatar-11.png",
                              height: 32,
                              width: 32,
                            ),
                          )
                              : Container(
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              child: bigCircle(transactionInfo.counterpartName??"")),//SOURCE
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text(
                                    transactionInfo.transactionId.substring(0,4) +
                                        ' • ' +
                                        Jiffy.unix(transactionInfo.timestamp).format("dd MMM, HH:mm"),//Utils().getDefaultFormattedDate(DateTime.fromMillisecondsSinceEpoch(transactionInfo.timestamp)),
                                    textAlign: TextAlign.left,
                                    style: BaseStyles.itemOrderQuantityTextStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text(
                                    transactionInfo.remarks,
                                    textAlign: TextAlign.left,
                                    style: TextStyles.bUTTONBlack2,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: ClipRect(
                                    clipBehavior: Clip.hardEdge,
                                    child: Text(
                                      "${transactionInfo?.selfBIC??""} ${transactionInfo?.selfAccountNumber?.split("#")[0]?.substring(10)??""}",//Utils().getMaskedAccountNumber(transactionInfo.counterpartAccountNumber??"), //SOURCE
                                      textAlign: TextAlign.left,
                                      style: BaseStyles.saveToMyContactTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3.toInt(),
                      child: Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 16),
                        child: RichText(
                          textAlign: TextAlign.right,
                            text: TextSpan(children: [
                              TextSpan(style: TextStyles.bUTTONRed2, text: "- "),
                              TextSpan(
                                  style: TextStyles.body22,
                                  text: transactionInfo.amount)
                            ])),
                      ),
                    )
                  ],
                ),
              )),
          Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  width: transactionInfo.success?84:70,
                  height: 20,
                  decoration: BoxDecoration(
                      gradient: transactionInfo.success?LinearGradient(
                          begin: Alignment(0.9999999999999998, 0.49999999999999983),
                          end: Alignment(-2.220446049250313e-16, 0.5000000000000002),
                          colors: [Color(0xffb2f7e2), const Color(0xffa1f0f8)]):
                      LinearGradient(
                          begin: Alignment(0.9999999999999998, 0.49999999999999983),
                          end: Alignment(-2.220446049250313e-16, 0.5000000000000002),
                          colors: [Colors.pink, const Color(0xfff950a3)]),
                      borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(20.0),
                      )),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 8,
                      bottom: 4,
                    ),

                    child: Align(
                      child: Container(
                        margin: EdgeInsets.only(top: 4,left: 8),
                        child: Text(
                          // "Test",
                          transactionInfo.success?getTranslation(Strings.success):getTranslation(Strings.failed),
                          textAlign: TextAlign.right,
                          style: TextStyles.caption222.copyWith(height: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
        onTap: () {});
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
