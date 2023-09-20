// import 'package:flutter/foundation.dart';

class Review {
  final String name;
  final String description;
  final String imgurl;
  final rating;
  final Category;
  Review(this.name, this.description, this.imgurl, this.rating, this.Category);
}

//sample data
List<Review> reviewList = [
  Review(
      "Alex Samuel",
      "I enjoyed the braiding you guys did, it magnifies mybeauty above expectation",
      "assets/images/ellipse-117.jpg",
      4.9,
      1),
  Review(
      "Alex Samuel",
      "I enjoyed the braiding you guys did, it magnifies mybeauty above expectation",
      "assets/images/ellipse-117.jpg",
      4.9,
      1),
  Review(
      "Alex Samuel",
      "I enjoyed the braiding you guys did, it magnifies mybeauty above expectation",
      "assets/images/ellipse-117.jpg",
      4.9,
      1),
  Review(
      "Alex Samuel",
      "I enjoyed the braiding you guys did, it magnifies mybeauty above expectation",
      "assets/images/ellipse-117.jpg",
      4.9,
      1),
  Review(
      "Alex Samuel",
      "I enjoyed the braiding you guys did, it magnifies mybeauty above expectation",
      "assets/images/ellipse-117.jpg",
      4.9,
      1),
];

// class Button {
//   final String name;
//   final category;

//    Button(this.name, this.category);
// }

// List<Button> buttonAdd = [Button("Alex Samuel", 1)];

// class Photos {
//   final String name;
//   final String imagurl;
//   final String amount;
//   final category2;
//    Photos(this.name, this.imagurl, this.amount, this.category2);
// }

// //sample data
// List<Photos> photosList = [
//   Photos("Alex Samuel", "assets/images/ellipse-117.jpg", "2000", 2),
//   Photos("Alex Samuel", "assets/images/ellipse-117.jpg", "2000", 2),
//   Photos("Alex Samuel", "assets/images/ellipse-117.jpg", "2000", 2),
//   Photos("Alex Samuel", "assets/images/ellipse-117.jpg", "2000", 2),
//   Photos("Alex Samuel", "assets/images/ellipse-117.jpg", "2000", 2),
// ];
