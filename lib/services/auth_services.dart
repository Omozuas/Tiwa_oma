import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/model/user.dart';
import 'package:Tiwa_Oma/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../utils/constraints.dart';

class AuthServices {
  void signUpUser({
    required BuildContext context,
    required String username,
    required String email,
    required String token,
    required String password,
    required String role,
    required String comfirmpassword,
    required String country,
    required String state,
    required String number,
    required String address,
    required String gender,
  }) async {
    try {
      User user = User(
          id: '',
          username: username,
          email: email,
          token: '',
          password: password,
          role: role,
          comfirmpassword: comfirmpassword,
          country: country,
          state: state,
          number: number,
          address: address,
          gender: gender);

      http.Response res = await http.post(
        Uri.parse('http://localhost:5000/auth/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'your accout has been created verify your email');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
