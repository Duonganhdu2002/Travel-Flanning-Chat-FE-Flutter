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

    debugPrint('------------------------------------------------------');
    debugPrint('Error updating user: ${response.statusCode}');
    debugPrint('Error updating user: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return ResponseFriendSending.fromJson(responseData);
    } else {
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

    debugPrint('------------------------------------------------------');
    debugPrint('Error updating user: ${response.statusCode}');
    debugPrint('Error updating user: ${response.body}');

    if (response.statusCode == 200) {
      return ResponseCheckFriend.fromJson(jsonDecode(response.body));
    } else {
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
      var jsonResponse = response.body;
      // Parse and return the response
      return ResponseUserDetail.fromJson(jsonDecode(jsonResponse));
    } else {
      return null;
    }
  }

  // Hàm gọi API và lưu dữ liệu vào cache
  static Future<void> fetchAndCacheAllUsers() async {
    var url = Uri.parse('${Config.apiURL}${Config.userList}');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      // Cache the response
      APICacheDBModel cacheModel =
          APICacheDBModel(key: cacheKey, syncData: jsonResponse);
      await APICacheManager().addCacheData(cacheModel);
    } else {
      throw Exception('Failed to fetch users from API');
    }
  }

  // Hàm lấy dữ liệu từ cache
  static Future<List<User>> getCachedUsers() async {
    bool isCacheExist = await APICacheManager().isAPICacheKeyExist(cacheKey);

    if (isCacheExist) {
      var cacheData = await APICacheManager().getCacheData(cacheKey);
      return responseAllUsers(cacheData.syncData);
    } else {
      throw Exception('No cached data found');
    }
  }

  // Send request to server. It recive object containing data
  // (User's information to login) from LoginRequestModel.
  static Future<bool?> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse('${Config.apiURL}${Config.loginApi}');
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    debugPrint('------------------------------------------------------');
    debugPrint('Error updating user: ${response.statusCode}');
    debugPrint('Error updating user: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response body to get the token string
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String accessToken = responseData['accessToken'];
      Map<String, dynamic> tokenData = JwtDecoder.decode(accessToken);
      // Process the decoded token data as needed
      await SharedService.setLoginDetails(
        loginResponseJson(jsonEncode(tokenData)),
      );

      debugPrint('Error updating user: $tokenData');

      return true;
    } else {
      return false;
    }
  }

  // Send request to server. It recive object containing data
  // (User's information to register) from LoginRequestModel.
  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse('${Config.apiURL}${Config.registerApi}');
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return registerResponseJson(response.body);
  }

  // Send a request to update user information
  static Future<bool> updateUser(UpdateUserRequestModel model) async {
    try {
      final url = Uri.parse('${Config.apiURL}${Config.updateUserApi}');

      debugPrint('Error updating user: $url');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      debugPrint('------------------------------------------------------');
      debugPrint('Error updating user: ${response.statusCode}');
      debugPrint('Error updating user: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }
}
