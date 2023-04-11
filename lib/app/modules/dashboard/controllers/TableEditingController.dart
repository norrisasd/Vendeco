import 'package:flutter/material.dart';
import 'package:vendeco/app/modules/dashboard/views/components/available_items.dart';

class TableEditingController extends ChangeNotifier {
  bool _isEditing = false;
  List<AvailableItems> _items = demoAvailableItems;
  List<AvailableItems> _tempItems = demoAvailableItems;
  bool get isEditing => _isEditing;
  List<AvailableItems> get latestAvailableItems => _items;
  List<AvailableItems> get tempAvailableItems => _tempItems;
  set latestAvailableItems(List<AvailableItems> value) {
    _items = value;
    notifyListeners();
  }

  void controlEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void updateTable(List<AvailableItems> updatedAvailableItems) {
    _tempItems = List<AvailableItems>.from(updatedAvailableItems);
    _items = List<AvailableItems>.from(updatedAvailableItems);
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void discardChanges() {
    _items = List<AvailableItems>.from(_tempItems);
    _isEditing = !_isEditing;
    notifyListeners();
  }
}
