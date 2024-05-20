import 'dart:convert';

List<User> responseAllUsers(String str) =>
    (json.decode(str) as List).map((data) => User.fromJson(data)).toList();

class DataResponseAllUser {
  String? message;
  List<User>? data;

  DataResponseAllUser({this.message, this.data});

  factory DataResponseAllUser.fromJson(Map<String, dynamic> json) {
    return DataResponseAllUser(
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => User.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class User {
  String? id;
  String? username;
  String? fullname;
  String? email;
  String? phone;
  List<dynamic>? waitingList;
  List<dynamic>? listFriend;
  List<dynamic>? bookMarkList;
  List<dynamic>? inviteList;
  List<String>? roles;

  User({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.phone,
    this.waitingList,
    this.listFriend,
    this.bookMarkList,
    this.inviteList,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      waitingList: json['waiting_list'] != null
          ? List<dynamic>.from(json['waiting_list'])
          : null,
      listFriend: json['list_friend'] != null
          ? List<dynamic>.from(json['list_friend'])
          : null,
      bookMarkList: json['book_mark_list'] != null
          ? List<dynamic>.from(json['book_mark_list'])
          : null,
      inviteList: json['invite_list'] != null
          ? List<dynamic>.from(json['invite_list'])
          : null,
      roles: json['roles'] != null ? List<String>.from(json['roles']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'waiting_list': waitingList,
      'list_friend': listFriend,
      'book_mark_list': bookMarkList,
      'invite_list': inviteList,
      'roles': roles,
    };
  }
}

class ResponseUserDetail {
  List<dynamic>? waitingList;
  List<dynamic>? listFriend;
  List<dynamic>? bookMarkList;
  String? phone;
  String? fullname;
  List<dynamic>? inviteList;
  String? id;
  String? username;
  String? email;
  List<String>? roles;
  ResponseUserDetail({
    this.waitingList,
    this.listFriend,
    this.bookMarkList,
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.phone,
    this.inviteList,
    this.roles,
  });

  factory ResponseUserDetail.fromJson(Map<String, dynamic> json) {
    return ResponseUserDetail(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      waitingList: json['waiting_list'] != null
          ? List<dynamic>.from(json['waiting_list'])
          : null,
      listFriend: json['list_friend'] != null
          ? List<dynamic>.from(json['list_friend'])
          : null,
      bookMarkList: json['book_mark_list'] != null
          ? List<dynamic>.from(json['book_mark_list'])
          : null,
      inviteList: json['invite_list'] != null
          ? List<dynamic>.from(json['invite_list'])
          : null,
      roles: json['roles'] != null ? List<String>.from(json['roles']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'waiting_list': waitingList,
      'list_friend': listFriend,
      'book_mark_list': bookMarkList,
      'invite_list': inviteList,
      'roles': roles,
    };
  }
}
