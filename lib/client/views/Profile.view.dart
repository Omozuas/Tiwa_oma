import 'dart:convert';
import 'dart:io';
import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:Tiwa_Oma/client/views/accountInfo.dart';
import 'package:Tiwa_Oma/client/views/AllBookings.dart';
import 'package:Tiwa_Oma/client/views/settingsView.dart';
import 'package:Tiwa_Oma/client/views/stylist.view.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/profileMenue.dart';
import 'Bookings.view.dart';

class MyProfile extends StatefulWidget {
  MyProfile({
    super.key,
    required this.token,
  });
  final token;
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String email = '';
  String username = '';
  String? profileImg = '';
  late final id;
  File? _pickedImage;
  final double profileHeiht = 120;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      id = jwtDecodedToken['id'];

      getuserById(id);
      print(jwtDecodedToken['email']);
      print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  Future<void> getuserById(id) async {
    GetUsers.fetchStylistData(widget.token, id).then((res) {
      setState(() {
        email = res.data['email'];
        username = res.data['username'];
        profileImg = res.data['profileImg'];
      });
    });
  }

  Future<void> _imagePicker() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      setState(() {
        _pickedImage = File(image.path);
      });

      final url = Uri.parse('https://api.cloudinary.com/v1_1/ddxaoh6po/upload');
      final requ = http.MultipartRequest("POST", url)
        ..fields["upload_preset"] = "hhnrmunf"
        ..files
            .add(await http.MultipartFile.fromPath('file', _pickedImage!.path));
      final res = await requ.send();
      if (res.statusCode == 200) {
        final resData = await res.stream.toBytes();
        final resSt = String.fromCharCodes(resData);
        final jmap = jsonDecode(resSt);
        setState(() {
          var url2 = jmap['url'];
          print(url2);
          UpdateuserInfoApi.updateUserImg(url2, widget.token, id).then((res) {
            if (res.status == true) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                  padding: const EdgeInsets.all(8),
                  height: 80,
                  decoration: BoxDecoration(
                    color: GlobalColors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
              ));
              getuserById(id);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
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
              ));
            }
          });
        });
      }

      setState(() {
        _pickedImage = File(image.path);
      });
      print(image.path);
    } else {
      print("no image has been picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await getuserById(id);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                  onTap: () {
                                    _imagePicker();
                                  },
                                  child: profileImg!.isEmpty
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: GlobalColors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: GlobalColors.blue,
                                              width: 3,
                                            ),
                                          ),
                                          width: 120,
                                          height: 120,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.asset(
                                                "assets/images/memoji-boys-5231.png",
                                              )),
                                        )
                                      : Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: GlobalColors.blue,
                                                width: 3,
                                              )),
                                          child: CircleAvatar(
                                            radius: profileHeiht / 2,
                                            backgroundColor: Colors.white,
                                            backgroundImage:
                                                NetworkImage("${profileImg}"),
                                          ))),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: GlobalColors.green,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: FaIcon(FontAwesomeIcons.pencil,
                                          size: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "${username}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  profileMenue(
                    icon: Ionicons.person_outline,
                    text: 'Account Information',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountInfo(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  profileMenue(
                    icon: LineIcons.book,
                    text: 'All Bookings',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllBookings(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  profileMenue(
                    icon: Ionicons.cog_outline,
                    text: 'Settings',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsView(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  profileMenue(
                    icon: Ionicons.lock_closed_outline,
                    text: 'Privacy Policy',
                    press: () {},
                  ),
                  profileMenue(
                    icon: Ionicons.warning_outline,
                    text: 'Help Center',
                    press: () {},
                  ),
                  profileMenue(
                    icon: Ionicons.log_out_outline,
                    text: 'Log Out',
                    press: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterAsView()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        color: GlobalColors.white,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      LineIcons.home,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Home',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bookings(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      LineIcons.book,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Bookings',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Stylist(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
                      Ionicons.cut_outline,
                      size: 30,
                    ),
                  ),
                  Text(
                    'stylist',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfile(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(Ionicons.person_outline,
                        size: 30, color: GlobalColors.yellow),
                  ),
                  Text('Profile', style: TextStyle(color: GlobalColors.yellow)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
