import 'dart:convert';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_request_model.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/models/register_request_model.dart';
import 'package:flutter_app/models/register_response_model.dart';
import 'package:flutter_app/models/update_request_model.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class APIService {
  static const String cacheKey = 'all_users';
  static Future<ResponseWaitingListRequest?> getWaitingList(
      String userId) async {
    var url = Uri.parse('${Config.apiURL}${Config.getWaitingListApi}$userId');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ResponseWaitingListRequest.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Error fetching waiting list: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return null;
    }
  }

  static Future<ResponseCheckWaitingListStatus?> checkWaitingListStatus(
      String userId1, String userId2) async {
    var url = Uri.parse('${Config.apiURL}${Config.checkWaitingListStatus}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          RequestCheckWaitingListStatus(userId1: userId1, userId2: userId2)
              .toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseCheckWaitingListStatus.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Error checking waiting list status: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return null;
    }
  }

  static Future<ResponseFriendSending?> sendFriendRequest(
      RequestFriendSending request) async {
    var url = Uri.parse('${Config.apiURL}${Config.sendFriendRequest}');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseFriendSending.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Error sending friend request: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      throw Exception('Failed to send friend request');
    }
  }

  static Future<ResponseCheckFriend?> checkFriendshipStatus(
      String userId1, String userId2) async {
    var url = Uri.parse('${Config.apiURL}${Config.checkFriend}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          RequestCheckFriend(userId1: userId1, userId2: userId2).toJson()),
    );

    if (response.statusCode == 200) {
      return ResponseCheckFriend.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Error checking friend status: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return null;
    }
  }

  static Future<void> removeCache(BuildContext context, String cacheKey) async {
    await APICacheManager().deleteCache(cacheKey);
  }

  static Future<ResponseUserDetail?> getUserDetail(
      BuildContext context, String userId) async {
    var url = Uri.parse('${Config.apiURL}api/user/user_detail/$userId');

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return ResponseUserDetail.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Error fetching user details: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return null;
    }
  }

  static Future<void> fetchAndCacheAllUsers() async {
    var url = Uri.parse('${Config.apiURL}${Config.userList}');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      APICacheDBModel cacheModel =
          APICacheDBModel(key: cacheKey, syncData: jsonResponse);
      await APICacheManager().addCacheData(cacheModel);
    } else {
      debugPrint('Error fetching all users: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      throw Exception('Failed to fetch users from API');
    }
  }

  static Future<List<User>> getCachedUsers() async {
    bool isCacheExist = await APICacheManager().isAPICacheKeyExist(cacheKey);

    if (isCacheExist) {
      var cacheData = await APICacheManager().getCacheData(cacheKey);
      return responseAllUsers(cacheData.syncData);
    } else {
      throw Exception('No cached data found');
    }
  }

  static Future<bool?> login(LoginRequestModel model) async {
    var url = Uri.parse('${Config.apiURL}${Config.loginApi}');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String accessToken = responseData['accessToken'];
      Map<String, dynamic> tokenData = JwtDecoder.decode(accessToken);
      await SharedService.setLoginDetails(
        loginResponseJson(jsonEncode(tokenData)),
      );
      return true;
    } else {
      debugPrint('Error logging in: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    var url = Uri.parse('${Config.apiURL}${Config.registerApi}');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return registerResponseJson(response.body);
    } else {
      debugPrint('Error registering user: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      throw Exception('Failed to register user');
    }
  }

  static Future<bool> updateUser(UpdateUserRequestModel model) async {
    try {
      final url = Uri.parse('${Config.apiURL}${Config.updateUserApi}');
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Error updating user: ${response.statusCode}');
        debugPrint('Error body: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }
}
