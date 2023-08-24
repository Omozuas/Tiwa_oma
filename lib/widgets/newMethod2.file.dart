// import 'dart:ffi';

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:Tiwa_Oma/widgets/pixCircle.dart';
// // import 'package:flutter/widgets.dart';

// Widget newMethod2() {
//   return Column(
//     children: [
//       SizedBox(
//         height: 50,
//       ),
//       Padding(
//         padding: EdgeInsets.all(20),
//         child: Row(
//           children: [
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/ellipse-117.jpg'),
//                         fit: BoxFit.cover)),
//                 // child: Image.asset('assets/images/ellipse-117.jpg'),
//               ),
//             ),
//             SizedBox(width: 10), // Spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome Back',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 SizedBox(height: 5), // Space between the two texts
//                 Text(
//                   'Alex Samuel',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ],
//             ),
//             Spacer(),
//             // Expands the space between text and notification icon
//             InkWell(
//               onTap: () {},
//               child: Icon(
//                 Icons.notifications_outlined,
//                 size: 35,
//               ),
//             ),
//             SizedBox(
//               width: 0.1,
//             ),
//             Positioned(
//                 child: Container(
//               margin: EdgeInsets.all(5),
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 3),
//                 color: Color(0XFFFF2F08),
//                 shape: BoxShape.circle,
//               ),
//             ))
//           ],
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 300,
//             height: 50, // Adjust the width of the search bar as needed
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.black),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search...',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 Icon(Icons
//                     .search), // Search icon inside the search bar at the right
//               ],
//             ),
//           ),
//           SizedBox(width: 10),
//           InkWell(
//             onTap: () {},
//             child: // Space between the search bar and the next search icon
//                 Container(
//               padding: EdgeInsets.all(15), // Adjust padding as needed
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 202, 157, 11), // Background color
//                   borderRadius: BorderRadius.circular(10)),
//               child: Icon(
//                 Icons.filter_list_outlined,
//                 color: Colors.white,
//                 size: 20,
//               ), // White search icon outside the search bar on the right
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Row(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'special Offer',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Container(
//               height: 138,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(12),
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/images/rectangle-1041.jpg'),
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   gradient: LinearGradient(
//                     begin: Alignment.center,
//                     stops: [0.1, 0.9],
//                     colors: [
//                       Colors.black.withOpacity(.5),
//                       Colors.black.withOpacity(.5)
//                     ],
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 17, horizontal: 18),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Discover Amazing Braids",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           SizedBox(
//                             height: 6,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Up to ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               Text(
//                                 "30%",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 7,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: Text('Claim'),
//                             style: ElevatedButton.styleFrom(
//                                 primary: Colors.yellow,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 elevation: 4,
//                                 minimumSize: Size(0, 30)),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 30,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Popular Stylist',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   width: 190,
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     'See All',
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 30,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: contents1.length,
//           itemBuilder: (context, index) {
//             return Container(
//               width: 100,
//               margin: EdgeInsets.only(left: 15),
//               padding: EdgeInsets.symmetric(vertical: 5),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset("assets/images/${context1[index]}",)
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     ],
//   );
// }
