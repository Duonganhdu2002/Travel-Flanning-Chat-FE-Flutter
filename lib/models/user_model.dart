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

class RequestFriendSending {
  String? userId1;
  String? userId2;

  RequestFriendSending({this.userId1, this.userId2});

  RequestFriendSending.fromJson(Map<String, dynamic> json) {
    userId1 = json['userId1'];
    userId2 = json['userId2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId1'] = userId1;
    data['userId2'] = userId2;
    return data;
  }
}

class ResponseFriendSending {
  bool? success;
  bool? result;

  ResponseFriendSending({this.success, this.result});

  ResponseFriendSending.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['result'] = result;
    return data;
  }
}

class RequestCheckFriend {
  String? userId1;
  String? userId2;

  RequestCheckFriend({this.userId1, this.userId2});

  RequestCheckFriend.fromJson(Map<String, dynamic> json) {
    userId1 = json['userId1'];
    userId2 = json['userId2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId1'] = userId1;
    data['userId2'] = userId2;
    return data;
  }
}

class ResponseCheckFriend {
  bool? areFriends;

  ResponseCheckFriend({this.areFriends});

  ResponseCheckFriend.fromJson(Map<String, dynamic> json) {
    areFriends = json['areFriends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['areFriends'] = areFriends;
    return data;
  }
}

class RequestCheckWaitingListStatus {
  String? userId1;
  String? userId2;

  RequestCheckWaitingListStatus({this.userId1, this.userId2});

  RequestCheckWaitingListStatus.fromJson(Map<String, dynamic> json) {
    userId1 = json['userId1'];
    userId2 = json['userId2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId1'] = userId1;
    data['userId2'] = userId2;
    return data;
  }
}

class ResponseCheckWaitingListStatus {
  bool? isInWaitingList;

  ResponseCheckWaitingListStatus({this.isInWaitingList});

  ResponseCheckWaitingListStatus.fromJson(Map<String, dynamic> json) {
    isInWaitingList = json['isInWaitingList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isInWaitingList'] = isInWaitingList;
    return data;
  }
}

class ResponseWaitingListRequest {
  List<WaitingList>? waitingList;

  ResponseWaitingListRequest({this.waitingList});

  factory ResponseWaitingListRequest.fromJson(Map<String, dynamic> json) {
    return ResponseWaitingListRequest(
      waitingList: json['waiting_list'] != null
          ? (json['waiting_list'] as List)
              .map((v) => WaitingList.fromJson(v))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (waitingList != null)
        'waiting_list': waitingList!.map((v) => v.toJson()).toList(),
    };
  }
}

class WaitingList {
  String? sId;
  String? username;

  WaitingList({this.sId, this.username});

  factory WaitingList.fromJson(Map<String, dynamic> json) {
    return WaitingList(
      sId: json['_id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'username': username,
    };
  }
}
