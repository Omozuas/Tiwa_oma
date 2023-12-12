import 'dart:convert';
import 'dart:io';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:Tiwa_Oma/services/updateApi.dart';
import 'package:Tiwa_Oma/stylist/StylistSettingsView.dart';
import 'package:Tiwa_Oma/view/Login.view.dart';
import 'package:Tiwa_Oma/view/RegisterAs.view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/StylistAccountInfo.dart';
import 'package:Tiwa_Oma/stylist/StylistDashboard.dart';
import 'package:Tiwa_Oma/stylist/StylistInfomation.dart';
import 'package:Tiwa_Oma/stylist/widgets/StylistProfileMenu.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../client/views/accountInfo.dart';
import '../utils/global.colors.dart';

class StylistProfile extends StatefulWidget {
  const StylistProfile({super.key, required this.token});
  final token;
  @override
  State<StylistProfile> createState() => _StylistProfileState();
}

class _StylistProfileState extends State<StylistProfile> {
  String email = '';
  String username = '';
  String? profileImg = '';
  late final id;
  File? _pickedImage;
  final double profileHeiht = 120;
  @override
  void initState() {
    super.initState();
    if (widget.token.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
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
                    Text('profile updateds',
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
        setState(() {
          var url2 = jmap['url'];
          print(url2);
          UpdateuserInfoApi.updateUserImg(url2, widget.token, id).then((value) {
            if (value.status == true) {
              getuserById(id);
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        elevation: 0,
        backgroundColor: GlobalColors.mainColor,
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
            padding: const EdgeInsets.all(8.0),
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
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: profileHeiht / 2,
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              NetworkImage("${profileImg}"),
                                        )),
                              ),
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
                    height: 20,
                  ),
                  StylistprofileMenue(
                    icon: Ionicons.person_outline,
                    text: 'Account Information',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistAccountInfo(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  StylistprofileMenue(
                    icon: Ionicons.cut_outline,
                    text: 'Stylist Infomation',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistInfomation(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  StylistprofileMenue(
                    icon: LineIcons.book,
                    text: 'All Bookings',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  StylistprofileMenue(
                    icon: Ionicons.cog_outline,
                    text: 'Settings',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistSettingView(
                                    token: widget.token,
                                  )));
                    },
                  ),
                  StylistprofileMenue(
                    icon: Ionicons.lock_closed_outline,
                    text: 'Privacy Policy',
                    press: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AccountInfo()));
                    },
                  ),
                  StylistprofileMenue(
                    icon: Ionicons.warning_outline,
                    text: 'Help Center',
                    press: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AccountInfo()));
                    },
                  ),
                  StylistprofileMenue(
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
        child: SizedBox(
          height: 65,
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
                              builder: (context) => StylistDashboard(
                                    token: widget.token,
                                  )));
                    },
                    child: const FaIcon(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAppointment(
                                    token: widget.token,
                                  )));
                    },
                    child: const FaIcon(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Clients(
                                    token: widget.token,
                                  )));
                    },
                    child: const Icon(
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylistProfile(
                                    token: widget.token,
                                  )));
                    },
                    child: Icon(
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
