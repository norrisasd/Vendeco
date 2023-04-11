import 'package:flutter/material.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey3 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey4 = GlobalKey<ScaffoldState>();
  final ScaffoldState _scaffoldKey = ScaffoldState();

  ScaffoldState get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    // if (!_scaffoldKey.currentState!.isDrawerOpen) {
    //   _scaffoldKey.currentState!.openDrawer();
    // }
  }
}
