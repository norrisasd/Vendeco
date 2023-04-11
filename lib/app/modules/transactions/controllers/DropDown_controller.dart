import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DropDownController extends ChangeNotifier {
  String _currentMonthForSales =
      DateFormat('MMMM').format(DateTime.now()).toString();
  String _currentMonthForTransactions =
      DateFormat('MMMM').format(DateTime.now()).toString();

  String get currentMonthForSales => _currentMonthForSales;
  String get currentMonthForTransactions => _currentMonthForTransactions;
  void changeMonthForSales(String month) {
    _currentMonthForSales = month;
    notifyListeners();
  }

  void changeMonthForTransactions(String month) {
    _currentMonthForTransactions = month;
    notifyListeners();
  }
}
