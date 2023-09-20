class ReviewModel {
  final feedback;
  final rating;
  final ReviewName userId;
  final category;

  ReviewModel({
    required this.userId,
    required this.rating,
    required this.feedback,
    required this.category,
  });
}

class ReviewName {
  final id;
  final String username;
  final String email;
  final String address;
  final String state;
  final String country;
  final String gender;
  final number;
  final String accountType;
  final profileImg;

  ReviewName(
      {required this.email,
      required this.id,
      required this.profileImg,
      required this.address,
      required this.state,
      required this.country,
      required this.gender,
      required this.number,
      required this.accountType,
      required this.username});
}
