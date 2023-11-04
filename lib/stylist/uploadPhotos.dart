import 'dart:convert';
import 'dart:io';
import 'package:Tiwa_Oma/services/providers/vendorApi.dart';
import 'package:Tiwa_Oma/stylist/StylistInfomation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import '../utils/global.colors.dart';
import '../widgets/signUp_filed.dart';
import 'AllAppointment.dart';
import 'Clients.dart';
import 'StylistDashboard.dart';
import 'package:http/http.dart' as http;

class UploadPhotos extends StatefulWidget {
  const UploadPhotos({super.key, this.token});
  final token;

  @override
  State<UploadPhotos> createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotos> {
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late final id;

  File? _pickedImage;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];
      print(jwtDecodedToken['email']);
      print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> _imagePicker() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });

      print(image.path);
    } else {
      print("no image has been picked");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Card(
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 226, 19, 43),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline_sharp,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'failed',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text("no image has been picked",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ))
                  ],
                ))
              ],
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
    }
  }

  Future<void> postDetails() async {
    if (formKey4.currentState!.validate() &&
        formKey5.currentState!.validate()) {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/ddxaoh6po/upload');
      final requ = http.MultipartRequest("POST", url)
        ..fields["upload_preset"] = "ijwyslib"
        ..files
            .add(await http.MultipartFile.fromPath('file', _pickedImage!.path));
      final res = await requ.send();
      if (res.statusCode == 200) {
        final resData = await res.stream.toBytes();
        final resSt = String.fromCharCodes(resData);
        final jmap = jsonDecode(resSt);

        var uploadinfo = {
          'stylistId': id,
          'nameOfHairStyle': descriptionController.text,
          'priceOfHairStyle': priceController.text,
          'hairStyleiImages': jmap['url'],
          'category': 2,
        };
        print(uploadinfo);
        VendorApi.uploadVendorDetails(widget.token, id, uploadinfo)
            .then((res) => {
                  if (res.success == true)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          decoration: BoxDecoration(
                            color: GlobalColors.green,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'success',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text("${res.message}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ))
                                ],
                              ))
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistInfomation(
                                    token: widget.token,
                                  )))
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Card(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 226, 19, 43),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline_sharp,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'failed',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(),
                                    Text('${res.message}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ))
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ))
                    }
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      signupFiled(
                          keys: formKey4,
                          label: "Price",
                          hintText: "price",
                          controller2: priceController,
                          keybordtype1: TextInputType.number,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter The Price";
                            } else {
                              return null;
                            }
                          }),
                      signupFiled(
                          keys: formKey5,
                          label: "Hair Style Name",
                          hintText: "hair style name",
                          controller2: descriptionController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your hair style name";
                            } else {
                              return null;
                            }
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      _imagePicker();
                    },
                    splashColor: Colors.white,
                    child: DottedBorder(
                      strokeWidth: 2,
                      radius: const Radius.circular(19),
                      padding: const EdgeInsets.all(1),
                      dashPattern: const [13, 8, 13],
                      borderType: BorderType.RRect,
                      child: _pickedImage == null
                          ? Container(
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
                                    const SizedBox(
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
                            )
                          : Image.file(
                              _pickedImage!,
                              fit: BoxFit.fill,
                            ),
                    )),
                const SizedBox(
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
                            postDetails();
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
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
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
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
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
                              builder: (context) => Clients(
                                    token: widget.token,
                                  )));
                    },
                    icon: const Icon(
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
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
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
