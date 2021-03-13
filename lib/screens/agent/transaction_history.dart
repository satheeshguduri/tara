import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/controller/transaction_history_controller.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/screens/base/base_state.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends BaseState<TransactionHistory> {
  TransactionHistoryController transactionHistoryController = Get.find();
  final key = GlobalKey<ScaffoldState>();

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }

  @override
  void initState() {
    super.initState();
    transactionHistoryController.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() => SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: _buildAppBar(context),
              body: getAllTransactions().withProgressIndicator(
                  showIndicator:
                      transactionHistoryController.showProgress.value)),
        ));
  }

  Widget getAllTransactions() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: getGroupedList()),
      ],
    );
  }

  Widget getGroupedList() {
    if (transactionHistoryController.searchInProgress.value &&
        transactionHistoryController.filteredTransactionList.isEmpty) {
      return errorTitleTextWidget();
    } else if (transactionHistoryController.totalTransactionList.isEmpty) {
      return ErrorStateInfoWidget(
        title: getTranslation(Strings.no_transaction_history_title),
        desc: getTranslation(Strings.no_transaction_history_desc),
      );
    } else {
      return Container(
        child: GroupedListView<TransactionListBean, String>(
          elements: transactionHistoryController.searchInProgress.value
              ? transactionHistoryController.filteredTransactionList.value
              : transactionHistoryController.totalTransactionList.value,
          groupBy: (element) => getGroupHeader(element.month),
          groupSeparatorBuilder: (String groupByValue) =>
              buildGroupHeaderWidget(groupByValue),
          itemBuilder: (context, TransactionListBean element) =>
              getTransactionInfoItemWidget(transactionInfo: element),
          groupComparator: (item1, item2) => item2.compareTo(item1),
          // optional
          // useStickyGroupSeparators: true, // optional
          // floatingHeader: true, // optional
          order: GroupedListOrder.ASC, // optional
        ),
      );
    }
  }

  Widget buildGroupHeaderWidget(String heading) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  Text(heading, style: BaseStyles.backAccountHeaderTextStyle),
            )),
      ],
    );
  }

  String getGroupHeader(String month) {
    return month;
  }

  AppBar _buildAppBar(BuildContext context) {
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
        left: 16,
      ),
      child: Text(
        getTranslation(Strings.we_cannot_find_anything) +
            "\"${transactionHistoryController.searchText.toString()}\"",
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
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: (transactionHistoryController.searchText
                        .toString()
                        .isNotEmpty)
                    ? AppColors.header_top_bar_color
                    : Colors.grey[400],
                width: 1),
          ),
          child: TextField(
            controller: transactionHistoryController.searchQuery,
            keyboardType: TextInputType.text,
            style: BaseStyles.baseTextStyle,
            cursorColor: AppColors.header_top_bar_color,
            autofocus: false,
            onChanged: (value) {
              transactionHistoryController.searchTransaction(value);
            },
            decoration: InputDecoration(
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
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear,
                    color: (transactionHistoryController.searchText != null &&
                            transactionHistoryController.searchText
                                .toString()
                                .isNotEmpty)
                        ? Colors.black54
                        : Colors.transparent),
                onPressed: () {
                  transactionHistoryController.searchText.value.isEmpty;
                  transactionHistoryController.searchQuery.clear();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getTransactionInfoItemWidget({TransactionListBean transactionInfo}) {
    return InkWell(
        child: Stack(children: [
          Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  //                   <--- left side
                  color: Color(0xffe9ecef),
                  width: 0.5,
                ),
                bottom: BorderSide(
                  //                    <--- top side
                  color: Color(0xffe9ecef),
                  width: 0.5,
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
                                  transactionInfo
                                      .success) //TODO  --- to check if tara user or not
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
                                  child: bigCircle(
                                      transactionInfo.counterpartName ??
                                          "")), //SOURCE
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${transactionInfo.transactionId.substring(0, 4)} • ${Jiffy.unix(transactionInfo.timestamp.toInt()).format("dd MMM, HH:mm")}', //Utils().getDefaultFormattedDate(DateTime.fromMillisecondsSinceEpoch(transactionInfo.timestamp)),
                                    textAlign: TextAlign.left,
                                    style:
                                        BaseStyles.itemOrderQuantityTextStyle,
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
                                      "${transactionInfo?.selfBIC ?? ''} ${transactionInfo?.selfAccountNumber == null ? '' : transactionInfo?.selfAccountNumber?.split('#')[0] ?? ''}", //Utils().getMaskedAccountNumber(transactionInfo.counterpartAccountNumber??"), //SOURCE
                                      textAlign: TextAlign.left,
                                      style:
                                          BaseStyles.saveToMyContactTextStyle,
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
                              TextSpan(
                                  style: TextStyles.bUTTONRed2, text: "- "),
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
                  width: transactionInfo.success ? 84 : 70,
                  height: 20,
                  decoration: BoxDecoration(
                      gradient: transactionInfo.success
                          ? LinearGradient(
                              begin: Alignment(0.9999999999999998,
                                  0.49999999999999983),
                              end:
                                  Alignment(-2.220446049250313e-16, 0.5000000000000002),
                              colors: [
                                  Color(0xffb2f7e2),
                                  const Color(0xffa1f0f8)
                                ])
                          : LinearGradient(
                              begin:
                                  Alignment(0.9999999999999998,
                                      0.49999999999999983),
                              end: Alignment(
                                  -2.220446049250313e-16, 0.5000000000000002),
                              colors: [Colors.pink, const Color(0xfff950a3)]),
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(20.0),
                      )),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 8,
                      bottom: 4,
                    ),
                    child: Align(
                      child: Container(
                        margin: EdgeInsets.only(top: 4, left: 8),
                        child: Text(
                          // "Test",
                          transactionInfo.success
                              ? getTranslation(Strings.success)
                              : getTranslation(Strings.failed),
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
        decoration: BoxDecoration(
          color: Color(0xff123456),
          shape: BoxShape.circle,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name.isNotEmpty ? name.substring(0, 1).toUpperCase() : "",
              style: BaseStyles.contactsTextStyle, textAlign: TextAlign.center),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
