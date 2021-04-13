import 'dart:convert';

import 'dart:typed_data';

User userFromJson(Uint8List str) =>
    User.fromJson(json.decode(utf8.decode(str)));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.nationalIdentityNo,
    this.name,
    this.surname,
  });

  String nationalIdentityNo;
  String name;
  String surname;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nationalIdentityNo: json["nationalIdentityNo"],
        name: json["name"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "nationalIdentityNo": nationalIdentityNo,
        "name": name,
        "surname": surname,
      };
}
