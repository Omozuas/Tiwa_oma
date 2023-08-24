import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/view/passwordChanged.view.dart';
import 'package:Tiwa_Oma/widgets/text_field.dart';

class setNewPassword extends StatefulWidget {
  const setNewPassword({super.key});

  @override
  State<setNewPassword> createState() => _setNewPasswordState();
}

class _setNewPasswordState extends State<setNewPassword> {
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isNotValidate = false;

  void create() async {
    if (password.text.isNotEmpty && confirmPassword.text.isNotEmpty) {
      // Your create function logic here
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const passWordChanged(
                  // token: myToken,
                  )));
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      obscureText: true,
                      label: "password",
                      hintText: "password",
                      suffixIcon2: const Icon(Icons.password),
                      controller2: password,
                      err: _isNotValidate ? "Enter Proper info" : null,
                      keyboardType4: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textFiled(
                      label: "confirmPassword",
                      hintText: "confirmPassword",
                      suffixIcon2: const Icon(Icons.visibility_off),
                      controller2: confirmPassword,
                      err: _isNotValidate ? "Enter Proper info" : null,
                      keyboardType4: TextInputType.visiblePassword,
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
