// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final ScaffoldState _scaffoldKey = ScaffoldState();

  ScaffoldState get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    // if (!_scaffoldKey.currentState!.isDrawerOpen) {
    //   _scaffoldKey.currentState!.openDrawer();
    // }
  }
}
