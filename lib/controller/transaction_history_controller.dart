import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../injector.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tara_app/common/helpers/base_request_helper.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/repositories/device_register_repository.dart';
import 'package:tara_app/repositories/transaction_repository.dart';

class TransactionHistoryController extends GetxController {
  var showProgress = false.obs;
  var transactionList = TransactionHistoryResponse().obs;
  var totalTransactionList = List<TransactionListBean>().obs;
  var filteredTransactionList = List<TransactionListBean>().obs;
  var searchInProgress = false.obs;

  var searchText = "".obs;

  TextEditingController searchQuery = TextEditingController();

  void getTransactions() async {
    showProgress.value = true;
    var isSessionInitiated =
        await getIt.get<DeviceRegisterRepository>().checkAndInitiateSession();
    if (isSessionInitiated) {
      var queries = await BaseRequestHelper().getCustomerDataQueryParam();

      var resp =
          await getIt.get<TransactionRepository>().getTxnHistory(queries);
      var transactionResp = resp.getOrElse(() => null);
      var transactionsListUpdated = <TransactionListBean>[];
      transactionResp.transactionList.forEach((element) {
        element.month = Jiffy.unix(element.timestamp).MMMM;
        transactionsListUpdated.add(element);
      });
      transactionResp.transactionList = transactionsListUpdated;
      transactionList.value = transactionResp;
      totalTransactionList.value = transactionList.value.transactionList;
    }
    showProgress.value = false;
  }

  void searchTransaction(String value) {
    searchInProgress.value = true;
    if (value.isEmpty) {
      searchInProgress.value = false;
      searchText.value = "";
      filteredTransactionList.clear();
    } else {
      searchInProgress.value = true;
      searchText.value = value;
      filteredTransactionList.value = totalTransactionList
          .where((transaction) => (transaction.remarks.toLowerCase() ?? "")
              .toLowerCase()
              .startsWith(value.toLowerCase()))
          .toList();
    }
  }
}
