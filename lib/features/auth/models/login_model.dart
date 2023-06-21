import 'dart:convert';

LoginModel? loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  String? token;
  String? message;
  Data? data;

  LoginModel({
    this.token,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
        token: json["token"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": data!.toJson(),
        "token": token,
        "message": message,
      };
}

class Data {
  String? firstName;
  String? lastName;
  String? emailAddress;
  int? userId;

  Data({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.userId,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        userId: json["id"],
        emailAddress: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": userId,
        "email": emailAddress,
        "first_name": firstName,
        "last_name": lastName,
      };
}
