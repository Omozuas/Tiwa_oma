import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/model/user.dart';
// import 'package:Tiwa_Oma/model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      username: '',
      email: '',
      token: '',
      password: '',
      role: '',
      comfirmpassword: '',
      country: '',
      state: '',
      number: '',
      address: '',
      gender: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
