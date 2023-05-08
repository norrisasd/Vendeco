import 'package:flutter/material.dart';

// class Transaction {
//   final String? date, product_name, dispensed_mL, price;

//   Transaction({this.date, this.product_name, this.dispensed_mL, this.price});
// }
import 'package:vendeco/app/modules/transactions/views/components/transactions.dart';

class TransactionsController extends ChangeNotifier {
  List<VendecoTransaction> _transactionList = [];
  List<VendecoTransaction> get getTransactionList => _transactionList;

  void setTransactionList(List<VendecoTransaction> newTransactionList) {
    _transactionList = newTransactionList;
    notifyListeners();
  }
}
