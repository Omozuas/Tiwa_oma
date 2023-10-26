import 'package:Tiwa_Oma/services/api.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/passwordChanged.view.dart';
import 'package:Tiwa_Oma/widgets/text_field.dart';

class setNewPassword extends StatefulWidget {
  const setNewPassword({super.key, this.userNumber});
  final userNumber;

  @override
  State<setNewPassword> createState() => _setNewPasswordState();
}

class _setNewPasswordState extends State<setNewPassword> {
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  bool _isVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  Future<void> create() async {
    if (formKey.currentState!.validate() && formKey1.currentState!.validate()) {
      // Your create function logic here
      var registerBody = {
        "password": password.text.toString(),
        "confirmPassword": confirmPassword.text.toString(),
      };
      var number = widget.userNumber;
      Api.changePassword(number, registerBody).then((res) {
        if (res.message == 'Password changed successfully') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const passWordChanged()));
        } else {
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              children: [
                Icon(
                  Icons.check,
                  size: 29,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${res.message}',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
            duration: Duration(seconds: 3),
          );
        }
      });
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Set New Password",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Create an extra layer of security by creating a unique password.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: GlobalColors.gray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    textFiled(
                      keys: formKey,
                      obscureText: !_isVisible,
                      label: "password",
                      hintText: "password",
                      suffixIcon2: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_outlined),
                        color: GlobalColors.darkshadeblack,
                      ),
                      controller2: password,
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^.*$').hasMatch(value!)) {
                          return "Enter Your Password";
                        } else {
                          return null;
                        }
                      },
                      keyboardType4: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textFiled(
                      keys: formKey1,
                      label: "confirmPassword",
                      hintText: "confirmPassword",
                      obscureText: !_isVisible,
                      suffixIcon2: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_outlined),
                        color: GlobalColors.darkshadeblack,
                      ),
                      controller2: confirmPassword,
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^.*$').hasMatch(value!)) {
                          return "Enter Your ComfirmPassword";
                        } else if (password.text.isEmpty ||
                            confirmPassword.text.isEmpty) {
                          return 'Both fields are required.';
                        } else if (password.text != confirmPassword.text) {
                          return 'Passwords do not match.';
                        } else {
                          return null;
                        }
                      },
                      keyboardType4: TextInputType.text,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            create();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29.0),
                              ),
                              minimumSize: const Size(370, 49)),
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
