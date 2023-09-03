import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/global.colors.dart';
import '../widgets/signUp_filed.dart';
import 'AllAppointment.dart';
import 'Clients.dart';
import 'StylistDashboard.dart';

class UploadPhotos extends StatefulWidget {
  const UploadPhotos({super.key});

  @override
  State<UploadPhotos> createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotos> {
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool _isNotValidate = false;

  File? _pickedImage;

  void UpDateStylistAccount() async {
    if (priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      // var responsed = await http.post(Uri.parse(registration),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(registerBody));
      // print(responsed);
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  Future<void> _imagePicker() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _pickedImage = selected;
        });
      } else {
        print("no image has been picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {});
      } else {
        print("no image has been picked");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Photo"),
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
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      signupFiled(
                          label: "price",
                          hintText: "price",
                          controller2: priceController,
                          err: _isNotValidate ? "Enter Proper info" : null,
                          keybordtype1: TextInputType.number),
                      signupFiled(
                        label: "description",
                        hintText: "description",
                        controller2: descriptionController,
                        err: _isNotValidate ? "Enter Proper info" : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadPhotos()));
                  },
                  splashColor: Colors.white,
                  child: DottedBorder(
                    strokeWidth: 2,
                    radius: Radius.circular(19),
                    padding: EdgeInsets.all(1),
                    dashPattern: [13, 8, 13],
                    borderType: BorderType.RRect,
                    child: Container(
                      width: 322,
                      height: 183,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: GlobalColors.blue,
                          ),
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.cloudArrowUp,
                              color: GlobalColors.darkshadeblack,
                              size: 86,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Browse file",
                              style: TextStyle(
                                  color: GlobalColors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            UpDateStylistAccount();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29.0),
                              ),
                              minimumSize: const Size(370, 49)),
                          child: const Text(
                            "Upload",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: SizedBox(
          height: 65,
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
                              builder: (context) => const StylistDashboard(
                                    token: '',
                                  )));
                    },
                    icon: const FaIcon(
                      LineIcons.home,
                      size: 30,
                    ),
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
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
                              builder: (context) => const AllAppointment()));
                    },
                    icon: const FaIcon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  const Text('Appointment'),
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
                              builder: (context) => const Clients()));
                    },
                    icon: Icon(
                      Ionicons.people_outline,
                      size: 32,
                    ),
                  ),
                  Text(
                    'client',
                    style: TextStyle(color: GlobalColors.darkshadeblack),
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
                              builder: (context) => const StylistProfile()));
                    },
                    icon: Icon(
                      Ionicons.person_outline,
                      size: 30,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(color: GlobalColors.yellow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
