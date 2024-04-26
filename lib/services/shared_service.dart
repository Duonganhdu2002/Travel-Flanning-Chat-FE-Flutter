import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/pages/login_page.dart';

class SharedService {
  // If you read this file, you should learn about cache on android phone.
  // We work with APICacheManager method:
  // - addCacheData
  // - isAPICacheKeyExist
  // - getCacheData
  // - deleteCache

  // This method save user's information to cache having name: "login_details".
  static Future<void> setLoginDetails(
    LoginResponseModel model,
  ) async {
    APICacheDBModel cacheDBManager = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(model.toJson()),
    );
    await APICacheManager().addCacheData(cacheDBManager);
  }

  // Method check user login. If not, return false.
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    return isCacheKeyExist;
  }

  // Get "login_details" cache, converting to json and store at LoginResponseModel.
  static Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return loginResponseJson(cacheData.syncData);
    }
    return null;
  }

  // Delete "login_details" from the cache.
  static Future<void> logOut(context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
