import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String _imageClicked = '';

  String get imageClicked => _imageClicked;

  void setImageClicked(String imageName) {
    _imageClicked = imageName;
    notifyListeners(); // Notify listeners about the change
  }
}
