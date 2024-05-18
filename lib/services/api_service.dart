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
  static Future<List<User>> getAllUsers() async {
    var cacheKey = 'all_users';
    var url = Uri.parse('${Config.apiURL}${Config.userList}');

    // Check if the data is already cached
    bool isCacheExist = await APICacheManager().isAPICacheKeyExist(cacheKey);

    if (isCacheExist) {
      var cacheData = await APICacheManager().getCacheData(cacheKey);
      return responseAllUsers(cacheData.syncData);
    } else {
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

        // Parse and return the response
        return responseAllUsers(jsonResponse);
      } else {
        return [];
      }
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
