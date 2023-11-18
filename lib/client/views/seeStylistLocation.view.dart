import 'dart:async';
import 'package:Tiwa_Oma/services/providers/components/constrains.dart';
import 'package:Tiwa_Oma/services/providers/components/getUsersApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';

class SeeLocationOfStylist extends StatefulWidget {
  const SeeLocationOfStylist({super.key, this.token});
  final token;
  @override
  State<SeeLocationOfStylist> createState() => _SeeLocationOfStylistState();
}

class _SeeLocationOfStylistState extends State<SeeLocationOfStylist> {
  String email = '';
  late final token;
  String username = '';
  late String fcmToken = '';
  late final id;
  String? profileImg = '';
  Map<PolylineId, Polyline> polyLines = {};
  @override
  void initState() {
    super.initState();
    _generateMarkers().then(
        (_) => getPolylinePionts().then((coordinates) => {print(coordinates)}));

    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    // id = jwtDecodedToken['id'];
    // try {
    //   email = jwtDecodedToken['email'];
    //   token = jwtDecodedToken['token'];

    //   getuserById(id);

    //   print("see $id");
    //   print(widget.token);
    // } catch (e) {
    //   // Handle token decoding errors here, e.g., log the error or show an error message.
    //   print('Error decoding token: $e');
    // }
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

  Location _locationController = new Location();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng _cameraPosition = LatLng(37.4223, -122.0848);
  // LatLng(6.605647, 3.349745);
  static const LatLng _cameraPosition2 = LatLng(37.3346, -122.0090);
  // LatLng(6.592454, 3.357495);
  LatLng? _lng = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Stylist Location"),
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
        body: _lng == null
            ? Center(
                child: Text("Loading..."),
              )
            : Stack(children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: _cameraPosition, zoom: 13),
                  onMapCreated: ((GoogleMapController controller) =>
                      _controller.complete(controller)),
                  markers: {
                    Marker(
                      markerId: MarkerId('_currentLocation'),
                      position: _lng!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                    ),
                    Marker(
                      markerId: MarkerId('_sourceLocation'),
                      position: _cameraPosition,
                    ),
                    Marker(
                      markerId: MarkerId('DestinationLocation'),
                      position: _cameraPosition2,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                    ),
                  },
                  polylines: Set<Polyline>.of(polyLines.values),
                ),
                // Positioned(
                //   left: 0,
                //   right: 0,
                //   bottom: 0,
                //   child: Container(
                //     child: Column(children: [
                //       Container(
                //         decoration: const BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(50.0),
                //             topRight: Radius.circular(50.0),
                //           ),
                //           color: Colors.white,
                //         ),
                //         child: Column(
                //           children: [
                //             const SizedBox(
                //               height: 20,
                //             ),
                //             Text(
                //               "Location",
                //               style: TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w600,
                //                   color: GlobalColors.darkshadeblack),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(18.0),
                //               child: Row(
                //                 children: [
                //                   ClipOval(
                //                     child: Image.asset(
                //                       "assets/images/portrait-of-young-woman-smiling-isolated.png",
                //                       width: 60,
                //                       height: 60,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                   const SizedBox(
                //                     width: 20,
                //                   ),
                //                   Expanded(
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.start,
                //                       children: [
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(
                //                               "Grace.A",
                //                               style: TextStyle(
                //                                   fontSize: 22,
                //                                   fontWeight: FontWeight.w600,
                //                                   color: GlobalColors.darkshadeblack),
                //                             ),
                //                             InkWell(
                //                               onTap: () {},
                //                               child: Icon(
                //                                 Icons.phone,
                //                                 color: GlobalColors.green,
                //                                 size: 24,
                //                               ),
                //                             )
                //                           ],
                //                         ),
                //                         const SizedBox(
                //                           height: 5,
                //                         ),
                //                         Row(
                //                           children: [
                //                             Icon(
                //                               Icons.location_on,
                //                               color: GlobalColors.green,
                //                               size: 24,
                //                             ),
                //                             Text(
                //                               "23, Osborne ikoyi lagos State",
                //                               style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 16,
                //                                   color: GlobalColors.shadeblack),
                //                             ),
                //                           ],
                //                         ),
                //                         const SizedBox(
                //                           height: 5,
                //                         ),
                //                         Row(
                //                           children: [
                //                             Icon(
                //                               Icons.phone,
                //                               color: GlobalColors.green,
                //                               size: 24,
                //                             ),
                //                             Text(
                //                               "07:56 arrivel",
                //                               style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 16,
                //                                   color: GlobalColors.shadeblack),
                //                             )
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             const SizedBox(
                //               height: 25,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.symmetric(
                //                 horizontal: 10,
                //               ),
                //               child: Container(
                //                 child: Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                     vertical: 20,
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.end,
                //                     children: [
                //                       ElevatedButton(
                //                         onPressed: () {
                //                           Navigator.push(
                //                               context,
                //                               MaterialPageRoute(
                //                                   builder: (context) => Dashboard(
                //                                         token: '',
                //                                       )));
                //                         },
                //                         style: ElevatedButton.styleFrom(
                //                             backgroundColor: Colors.black,
                //                             shape: RoundedRectangleBorder(
                //                               borderRadius:
                //                                   BorderRadius.circular(29.0),
                //                             ),
                //                             minimumSize: const Size(379, 50)),
                //                         child: const Text(
                //                           "Go Home",
                //                           style: TextStyle(
                //                               fontSize: 16,
                //                               fontWeight: FontWeight.w600),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     ]),
                //   ),
                // ),
              ]));
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> _generateMarkers() async {
    bool _serviceEnable;
    PermissionStatus _permissionGraned;
    _serviceEnable = await _locationController.serviceEnabled();
    if (_serviceEnable) {
      _serviceEnable = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGraned = await _locationController.hasPermission();
    if (_permissionGraned == PermissionStatus.denied) {
      _permissionGraned = await _locationController.requestPermission();
      if (_permissionGraned != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _lng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_lng!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePionts() async {
    List<LatLng> polylineCoordinate = [];
    PolylinePoints polylinePoints = PolylinePoints();
    print(google_api_key);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(_cameraPosition.latitude, _cameraPosition.longitude),
        PointLatLng(_cameraPosition2.latitude, _cameraPosition2.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng points) {
        polylineCoordinate.add(LatLng(points.latitude, points.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinate;
  }

  void drawPolylines(List<LatLng> polylineCoordinates) async {
    PolylineId id1 = PolylineId('poly');
    Polyline _polyline = Polyline(
        polylineId: id1,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polyLines[id1] = _polyline;
    });
  }
}
