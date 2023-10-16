import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _globalKey;

  void controllerMenue() {
    if (!_globalKey.currentState!.isDrawerOpen) {
      _globalKey.currentState!.openDrawer();
    }
  }
}
