import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:Tiwa_Oma/client/views/dashboard.view.dart';

class SeeLocationOfStylist extends StatefulWidget {
  const SeeLocationOfStylist({super.key});

  @override
  State<SeeLocationOfStylist> createState() => _SeeLocationOfStylistState();
}

class _SeeLocationOfStylistState extends State<SeeLocationOfStylist> {
  List<Map<String, dynamic>> data = [
    {
      'id': '1',
      'position': const LatLng(1.32, 103.80),
      'assetPath': 'assets/images/ic-pick.png'
    },
    {
      'id': '2',
      'position': const LatLng(1.34, 103.84),
      'assetPath': 'assets/images/rectangle-1042.png'
    }
  ];

  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(1.35, 103.8), zoom: 12.0);
  @override
  void initState() {
    // TODO: implement initState
    _generateMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var markers = {
    //   const Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(1.35, 103.8),
    //   ),
    //   Marker(
    //     markerId: MarkerId('2'),
    //     position: LatLng(1.32, 103.82),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //   ),
    // };
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Stylist Location"),
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
        body: Stack(children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            initialCameraPosition: _cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: _polyline,
            markers: _markers.values.toSet(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: GlobalColors.darkshadeblack),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "assets/images/portrait-of-young-woman-smiling-isolated.png",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Grace.A",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: GlobalColors.darkshadeblack),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.phone,
                                          color: GlobalColors.green,
                                          size: 24,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: GlobalColors.green,
                                        size: 24,
                                      ),
                                      Text(
                                        "23, Osborne ikoyi lagos State",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: GlobalColors.shadeblack),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: GlobalColors.green,
                                        size: 24,
                                      ),
                                      Text(
                                        "07:56 arrivel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: GlobalColors.shadeblack),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard(
                                                  token: '',
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(29.0),
                                      ),
                                      minimumSize: Size(379, 50)),
                                  child: const Text(
                                    "Go Home",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ]));
  }

  _generateMarkers() async {
    for (int i = 0; i < data.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        data[i]['assetPath'],
      );

      _markers[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position: data[i]['position'],
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: 'your location',
          ));
      setState(() {});
    }
  }
}
