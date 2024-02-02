import 'dart:convert';

class UserModel {
  String? userId;
  String userName;
  String userEmail;
  String userPassword;
  List<dynamic> userPhone;
  String userAddress;
  String userDate;
  String role;

  UserModel({
    this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    required this.userAddress,
    required this.userDate,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'fullName': userName,
      'email': userEmail,
      'password': userPassword,
      'phoneNumber': userPhone,
      'address': userAddress,
      'date': userDate,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id'].toString(),
      userName: json['fullName'],
      userEmail: json['email'],
      userPassword: json['password'],
      userPhone: json['phoneNumber'],
      userAddress: json['address'],
      userDate: json['date'],
      role: json['role'] ?? "user",
    );
  }

  String toJsonString() {
    return '''
    {
      "_id": "$userId",
      "fullName": "$userName",
      "email": "$userEmail",
      "password": "$userPassword",
      "phoneNumber": "${userPhone[0].toString()}",
      "address": "$userAddress",
      "date": "$userDate",
      "role": "$role"
    }
    ''';
  }

  factory UserModel.fromJsonString(String jsonString) {
    final Map<String, dynamic> json =
        jsonDecode(jsonString); // Use jsonDecode to parse the JSON string
    return UserModel(
      userId: json['_id'],
      userName: json['fullName'],
      userEmail: json['email'],
      userPassword: json['password'],
      userPhone: (json["phoneNumber"] != null && json["phoneNumber"].isNotEmpty)
          ? [json["phoneNumber"].toString()]
          : [],
      userAddress: json['address'],
      userDate: json['date'],
      role: json['role'] ?? "user",
    );
  }
}
