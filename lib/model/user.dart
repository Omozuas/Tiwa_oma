import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String token;
  final String password;
  final String role;
  final String comfirmpassword;
  final String country;
  final String state;
  final String number;
  final String address;
  final String gender;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    required this.password,
    required this.role,
    required this.comfirmpassword,
    required this.country,
    required this.state,
    required this.number,
    required this.address,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'token': token,
      'password': password,
      'role': role,
      'comfirmpassword': comfirmpassword,
      'country': country,
      'state': state,
      'number': number,
      'address': address,
      'gender': gender,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
      comfirmpassword: map['comfirmpassword'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      number: map['number'] ?? '',
      address: map['address'] ?? '',
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
