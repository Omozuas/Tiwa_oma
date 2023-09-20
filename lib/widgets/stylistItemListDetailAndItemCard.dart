import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:Tiwa_Oma/services/providers/vendorApi.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class StylistItemdetails extends StatefulWidget {
  StylistItemdetails({super.key, required this.vendorStylist, this.token});
  List<VendorModel> vendorStylist = [];
  final token;
  @override
  State<StylistItemdetails> createState() => _StylistItemdetailsState();
}

class _StylistItemdetailsState extends State<StylistItemdetails> {
  late String email;
  late final token;
  late final id;
  late String username;
  Future<void> fetchVendorData() async {
    final response = await VendorApi.fetchVendorData(widget.token, '');
    setState(() {
      widget.vendorStylist = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchVendorData();
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.vendorStylist
          .map((e) => StylistItemCardDetails(
                vendorModel: e,
                token: widget.token,
              ))
          .toList(),
    );
  }
}

class StylistItemCardDetails extends StatefulWidget {
  StylistItemCardDetails(
      {super.key, required this.vendorModel, required this.token});
  VendorModel vendorModel;
  final token;

  @override
  State<StylistItemCardDetails> createState() => _StylistItemCardDetailsState();
}

class _StylistItemCardDetailsState extends State<StylistItemCardDetails> {
  final double coverHight = 240;
  final double profileHeiht = 120;

  late String email;
  late final token;
  late final id;
  late String username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.vendorModel.stylistModel.id);
    // VendorApi.fetchVendorData(widget.token, widget.vendorModel.stylistModel.id);
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.grey,
          child: InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/rectangle-1031.png",
              height: coverHight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 180,
          child: widget.vendorModel.stylistModel.profileImg == null
              ? Container(
                  child: CircleAvatar(
                  radius: profileHeiht / 2,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      const AssetImage("assets/images/rectangle-1031.png"),
                ))
              : Container(
                  child: CircleAvatar(
                  radius: profileHeiht / 2,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      "${widget.vendorModel.stylistModel.profileImg}"),
                )),
        ),
        Container(
            child: Positioned(
          top: 307,
          child: Text(
            widget.vendorModel.stylistModel.username,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          ),
        )),
        Container(
            child: Positioned(
          top: 220,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    size: 35,
                    color: GlobalColors.yellow,
                    weight: 500,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text("(5.0)",
                      style: TextStyle(color: GlobalColors.gray, fontSize: 17)),
                  const SizedBox(
                    width: 205,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 75,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 136, 236, 139),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(100),
                          bottom: Radius.circular(100)),
                    ),
                    child: const Center(
                      child: Text(
                        "open",
                        style: TextStyle(
                            color: Color.fromARGB(255, 27, 120, 30),
                            fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        )),
        Container(
            child: Positioned(
          top: 350,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.red,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.vendorModel.stylistModel.address,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: GlobalColors.gray),
            )
          ]),
        )),
      ],
    );
  }
}
