import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/onboarding/onboard.model.dart';

class LoginAndSignup extends StatelessWidget {
  const LoginAndSignup({
    super.key,
    required this.role,
  });
  final String role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        role: role,
      ),
    );
  }
}
