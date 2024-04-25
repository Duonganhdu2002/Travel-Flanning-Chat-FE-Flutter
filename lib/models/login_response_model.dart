import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  String? id;
  String? username;
  String? email;
  List<String>? roles;
  String? accessToken;

  LoginResponseModel(
      {this.id, this.username, this.email, this.roles, this.accessToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: List<String>.from(json['roles'] ?? []),
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'email': email,
      'roles': roles,
      'accessToken': accessToken,
    };
    return data;
  }
}
