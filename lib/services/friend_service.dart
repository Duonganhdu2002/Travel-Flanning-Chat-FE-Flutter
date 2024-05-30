import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:http/http.dart' as http;

class FriendService {
  static Future<void> sendFriendRequest(
      String senderId, String receiverId) async {
    final url = Uri.parse('${Config.apiURL}api/user/send-friend-request');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'senderId': senderId, 'receiverId': receiverId}),
    );

    debugPrint("Friend request response status: ${response.statusCode}");
    debugPrint("Friend request response body: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception('Failed to send friend request');
    }
  }

  static Future<Map<String, dynamic>?> checkFriendStatus(
      String userId1, String userId2) async {
    final url = Uri.parse('${Config.apiURL}api/user/check-friend-status');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId1': userId1, 'userId2': userId2}),
    );

    debugPrint("Check friend status response status: ${response.statusCode}");
    debugPrint("Check friend status response body: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<List<Map<String, String>>> getFriendRequests(
      String userId) async {
    final url = Uri.parse('${Config.apiURL}api/user/waiting_list/$userId');
    final response = await http.get(url);

    debugPrint("Get friend requests response status: ${response.statusCode}");
    debugPrint("Get friend requests response body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['waiting_list'];
      return data.map((item) {
        return {
          'userId': item['id'].toString(),
          'username': item['username'].toString(),
        };
      }).toList();
    } else {
      throw Exception('Failed to load friend requests');
    }
  }
}
