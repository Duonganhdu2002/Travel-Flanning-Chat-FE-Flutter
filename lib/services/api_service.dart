import 'dart:convert';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_request_model.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/models/register_request_model.dart';
import 'package:flutter_app/models/register_response_model.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:http/http.dart' as http;

class APIService {
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
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
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
}
