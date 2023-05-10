import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  bool _isNotificationOpened = false;
  bool get isNotificationOpened => _isNotificationOpened;

  void changeNotificationStatus() {
    _isNotificationOpened = true;
    notifyListeners();
  }

  void resetNotificationStatus() {
    _isNotificationOpened = false;
    notifyListeners();
  }
}
