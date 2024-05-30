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

class AuthService {
  static const String cacheKey = 'all_users';

  static Future<bool> resetPassword(String email, String newPassword) async {
    var url = Uri.parse('${Config.apiURL}api/auth/forgot-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Error resetting password: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return false;
    }
  }

  static Future<bool> verifyOTP(
      String email, String otp, String username, String password) async {
    var url = Uri.parse('${Config.apiURL}api/auth/verify-signup-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'otp': otp,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Error verifying OTP: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return false;
    }
  }

  static Future<Map<String, dynamic>> sendResetOTP(String email) async {
    var url = Uri.parse('${Config.apiURL}api/auth/send-reset-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint('Error sending OTP: ${response.statusCode}');
      debugPrint('Error body: ${response.body}');
      return {};
    }
  }

  static Future<ResponseUserDetail?> getUserDetail(
      BuildContext context, String userId) async {
    final url = Uri.parse('${Config.apiURL}api/user/user_detail/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ResponseUserDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }

  static Future<void> removeCache(BuildContext context, String cacheKey) async {
    await APICacheManager().deleteCache(cacheKey);
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
      RegisterRequestModel model) async {
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
      throw Exception('Failed to register user: ${response.body}');
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
