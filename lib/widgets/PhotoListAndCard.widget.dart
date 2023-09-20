// import 'package:flutter/foundation.dart';

import 'package:Tiwa_Oma/client/views/stylistReviews.view.dart';
import 'package:Tiwa_Oma/services/model/stylist_model.dart';
import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class PhotoList2 extends StatefulWidget {
  PhotoList2({super.key, required this.pic, this.ontap, this.token});
  List<VendorModel> pic = [];
  final ontap;

  final token;
  @override
  State<PhotoList2> createState() => _PhotoList2State();
}

class _PhotoList2State extends State<PhotoList2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.pic
          .map((e) => PhotoList2Card(
                pic: e,
                ontap: widget.ontap,
              ))
          .toList(),
    );
  }
}

class PhotoList2Card extends StatefulWidget {
  PhotoList2Card({
    super.key,
    required this.pic,
    this.ontap,
  });
  VendorModel pic;
  final ontap;

  @override
  State<PhotoList2Card> createState() => _PhotoList2CardState();
}

class _PhotoList2CardState extends State<PhotoList2Card> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                widget.ontap;
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Card(
                        elevation: isSelected ? 0.9 : 0.8,
                        color: isSelected ? GlobalColors.yellow : null,
                        child: Container(
                          width: 172,
                          height: 129,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/cartoon.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.pic.hairStlye,
                        style: TextStyle(
                          color: isSelected ? GlobalColors.yellow : Colors.grey,
                          fontSize: isSelected ? 14 : 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.currency_pound_outlined,
                        color: isSelected ? GlobalColors.yellow : Colors.black,
                      ),
                      Text(
                        '${widget.pic.hartPrice}',
                        style: TextStyle(
                          color:
                              isSelected ? GlobalColors.yellow : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PhotoList extends StatefulWidget {
  PhotoList({
    required this.token,
    this.photodetails,
    super.key,
    required this.vendorStylist,
    required this.onTap,
  });

  final token;
  var photodetails;
  var onTap;

  List<VendorModel> vendorStylist = [];

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  late String email;
  late final token;
  late final id;
  late String username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // VendorApi.fetchVendorData(widget.token, widget.stylistModel.id);
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    try {
      email = jwtDecodedToken['email'];
      token = jwtDecodedToken['token'];
      username = jwtDecodedToken['username'];
      id = jwtDecodedToken['id'];
      // print(id);
      // print(jwtDecodedToken['email']);
      // print(widget.token);
    } catch (e) {
      // Handle token decoding errors here, e.g., log the error or show an error message.
      print('Error decoding token: $e');
    }
  }

  bool isSelected = false;
  bool isSelected2 = false; // Track whether the card is selected
  @override
  Widget build(BuildContext context) {
    var detais = widget.photodetails;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.vendorStylist.length,
            itemBuilder: (context, index) {
              final pix = widget.vendorStylist[index];
              return Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.onTap = {
                            'hairName': pix.hairStlye,
                            "price": pix.hartPrice,
                            "hairImg": pix.hairStyleImg,
                          };
                          widget.photodetails = {
                            'hairName': pix.hairStlye,
                            "price": pix.hartPrice,
                            "hairImg": pix.hairStyleImg,
                          };

                          print(widget.photodetails);
                          // Toggle the selected state
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Card(
                                  elevation: isSelected ? 0.9 : 0.8,
                                  color:
                                      isSelected ? GlobalColors.yellow : null,
                                  child: pix.hairStyleImg == null
                                      ? Container(
                                          width: 172,
                                          height: 129,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/memoji-boys-5231.png'),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 172,
                                          height: 129,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                '${pix.hairStyleImg}',
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  pix.hairStlye,
                                  style: TextStyle(
                                    color: isSelected
                                        ? GlobalColors.yellow
                                        : Colors.grey,
                                    fontSize: isSelected ? 14 : 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.currency_pound_outlined,
                                  color: isSelected
                                      ? GlobalColors.yellow
                                      : Colors.black,
                                ),
                                Text(
                                  '${pix.hartPrice}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? GlobalColors.yellow
                                        : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // if (_currentSelection == 2) {
                      //   // _selectedItem(3);
                      // }
                      print(widget.photodetails);
                      print(widget.token);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                        minimumSize: const Size(379, 50)),
                    child: const Text(
                      "Proceed",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
