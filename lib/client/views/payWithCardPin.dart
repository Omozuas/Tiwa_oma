import 'package:Tiwa_Oma/client/views/TransactionReview.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class payWithCardPin extends StatefulWidget {
  const payWithCardPin({super.key});

  @override
  State<payWithCardPin> createState() => _payWithCardPinState();
}

class _payWithCardPinState extends State<payWithCardPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pay With Card"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/images/mdi-security-lock-outline.svg',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Enter Pin",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please enter your pin to proceed",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.gray),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 4; i++)
                      textFieldOpt(
                          isFirst: i == 0, isLast: i == 3, context: context),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const transactionReview(
                              // token: '',
                              // token: myToken,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29.0),
                    ),
                    minimumSize: const Size(370, 49)),
                child: const Text(
                  "Verify",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "I did not receive an OTP,",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: GlobalColors.gray),
                ),
                Text(
                  "Resend",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: GlobalColors.blue),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFieldOpt(
    {required bool isFirst, isLast, required BuildContext context}) {
  return SizedBox(
    width: 50,
    height: 85,
    child: TextField(
      onChanged: (value) {
        if (value.isNotEmpty && !isLast) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty && !isFirst) {
          FocusScope.of(context).previousFocus();
        }
      },
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      decoration: InputDecoration(
        counter: const Offstage(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: GlobalColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: GlobalColors.green),
        ),
      ),
    ),
  );
}
