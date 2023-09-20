import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/view/LoginAndSignup.view.dart';
import '../widgets/widgets.dart';

class RegisterAsView extends StatelessWidget {
  const RegisterAsView({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedRole = " ";
    return Stack(
      children: [
        const BackgroundImg(),
        const Scaffold(
          backgroundColor: Colors.transparent,
        ),
        Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print(selectedRole);
                          selectedRole = "client";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginAndSignup(accountType: selectedRole)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 46)),
                        child: const Text("As Client"),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          print(selectedRole);
                          selectedRole = 'stylist';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginAndSignup(accountType: selectedRole)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            minimumSize: const Size(370, 46)),
                        child: const Text("As Stylist"),
                      )
                    ],
                  ),
                )))
      ],
    );
  }
}
