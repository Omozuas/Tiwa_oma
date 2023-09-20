// import 'package:Tiwa_Oma/services/api.dart';
// import 'package:flutter/material.dart';

// import '../utils/global.colors.dart';
// import 'Review.view.dart';

// class ItemListStateful extends StatefulWidget {
//   final List<Review> categoryReview;

//   ItemListStateful({required this.categoryReview, Key? key}) : super(key: key);

//   @override
//   _ItemListState createState() => _ItemListState();
// }

// class _ItemListState extends State<ItemListStateful> {
//   List<dynamic> users = [];
//   @override
//   void initState() {
//     super.initState();

//     try {
//       Api.getreviewgApp().then((response) {
//         print(response.message);

//         for (int index = 0; index < response.data.length; index++) {
//           // print("Index $index: ${response.data[index]['rating']}");
//           // username2 = response.data[index]['userId']['username'];
//           // rating = response.data[index]['rating'];
//           var data = response.data[index];
//           var userId = response.data[index]['userId'];
//           var username = response.data[index]['userId']['username'];
//           var rating = response.data[index]['rating'];
//           var feedback = response.data[index]['feedback'];
//           var profilImg = response.data[index]['profilImg'];
//           // print(username2);
//           // print(rating);
//           setState(() {
//             // users = data;
//             userId;
//             //  = userId;
//             username;
//             //  = username;
//             rating;
//             //  = rating;
//             feedback;
//             // =feedback;
//             profilImg;
//             // =profilImg;
//             // print(data);
//             // print(userId);
//             print(users);
//           });
//         }

//         // print(response.data as List);
//         // print(response.success);
//       });
//     } catch (e) {
//       // Handle token decoding errors here, e.g., log the error or show an error message.
//       print('Error decoding token: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: widget.categoryReview.map((e) => ItemCard(review: e)).toList(),
//     );
//   }
// }

// class ItemCard extends StatefulWidget {
//   const ItemCard({required this.review, Key? key}) : super(key: key);
//   final Review review;

//   @override
//   _ItemCardState createState() => _ItemCardState();
// }

// class _ItemCardState extends State<ItemCard> {
//   // late String username2;
//   // late final rating;

//   // late final data1;

//   @override
//   void initState() {
//     super.initState();

//     try {
//       Api.getreviewgApp().then((response) {
//         print(response.message);

//         for (int index = 0; index < response.data.length; index++) {
//           // print("Index $index: ${response.data[index]['rating']}");
//           // username2 = response.data[index]['userId']['username'];
//           // rating = response.data[index]['rating'];
//           var data = response.data[index];
//           var userId = response.data[index]['userId'];
//           var username = response.data[index]['userId']['username'];
//           var rating = response.data[index]['rating'];
//           var feedback = response.data[index]['feedback'];
//           var profilImg = response.data[index]['profilImg'];
//           // print(username2);
//           // print(rating);
//           setState(() {
//             data = users;

//             userId;
//             //  = userId;
//             username;
//             //  = username;
//             rating;
//             //  = rating;
//             feedback;
//             // =feedback;
//             profilImg;
//             // =profilImg;
//             // print(data);
//             // print(userId);
//             print(users);
//           });
//         }

//         // print(response.data as List);
//         // print(response.success);
//       });
//     } catch (e) {
//       // Handle token decoding errors here, e.g., log the error or show an error message.
//       print('Error decoding token: $e');
//     }
//   }

//   List<dynamic> users = [];
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child: Card(
//             elevation: 0.9,
//             margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//             child: Row(
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             width: 60,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                   widget.review.imgurl,
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 0,
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 widget.review.name,
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star_outlined,
//                                     color: GlobalColors.yellow,
//                                   ),
//                                   Text('${widget.review.rating}'),
//                                   const SizedBox(
//                                     width: 20,
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             widget.review.description,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 17,
//                             ),
//                             softWrap: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
