import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

import 'package:Tiwa_Oma/client/views/Profile.view.dart';

// import 'package:Tiwa_Oma/view/TransactionReview.view.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:Tiwa_Oma/widgets/FormCardText.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

import 'Bookings.view.dart';
import 'TransactionReview.dart';
import 'dashboard.view.dart';

class payWithCard extends StatefulWidget {
  const payWithCard({super.key});

  @override
  State<payWithCard> createState() => _payWithCardState();
}

class _payWithCardState extends State<payWithCard> {
  bool isChecked = false; // Initial state of the checkbox

  TextEditingController cardNumberController = TextEditingController();

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
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    formCardFiled(
                        label: "Card number",
                        hintText: "Card number",
                        keybordtype1: TextInputType.number,
                        inputeformat1: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                          CardNumberInputForm(),
                        ],
                        onchange3: (value) {
                          print(value);
                        },
                        controller2: cardNumberController),
                    const SizedBox(
                      height: 0,
                    ),
                    const Row(
                      children: [
                        Text('Alex Samuel'),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: formCardFiled(
                              label: 'Expiry Date',
                              hintText: 'Expiry Date',
                              inputeformat1: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.digitsOnly,
                                CardMonthInputForm()
                              ],
                              keybordtype1: TextInputType.number),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: formCardFiled(
                              label: 'CVV',
                              hintText: 'CVV',
                              inputeformat1: [
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keybordtype1: TextInputType.number),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              child: Checkbox(
                                checkColor: GlobalColors.textColor1,
                                hoverColor: GlobalColors.yellow,
                                value: isChecked,
                                activeColor: Colors.yellow.shade700,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked =
                                        value ?? false; // Update the state
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Text(
                              isChecked ? 'Saved Card' : 'Save card',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const transactionReview()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29.0),
                              ),
                              minimumSize: const Size(370, 49)),
                          child: const Text(
                            "Proceed",
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        child: SizedBox(
          height: 69,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard(
                                    token: '',
                                  )));
                    },
                    icon: const Icon(
                      LineIcons.home,
                      size: 32,
                    ),
                  ),
                  const Text(
                    'Home',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Bookings()));
                    },
                    icon: const Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Bookings'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Stylist()));
                    },
                    icon: Icon(
                      Ionicons.cut_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text('stylist', style: TextStyle(color: GlobalColors.yellow)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfile()));
                    },
                    icon: const Icon(
                      Ionicons.person_outline,
                      size: 30,
                    ),
                  ),
                  const Text('Profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
