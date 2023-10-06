class UserModel {
  final username;
  final email;
  final address;
  final country;
  final state;
  final accountType;
  final gender;
  final number;
  final id;
  final profileImg;
  final stripeCostormerId;

  UserModel(
      {required this.username,
      required this.email,
      required this.address,
      required this.country,
      required this.state,
      required this.accountType,
      required this.gender,
      required this.number,
      required this.id,
      this.profileImg,
      this.stripeCostormerId});
}
