import 'dart:convert';
import 'package:flutter_app/config.dart';
import 'package:http/http.dart' as http;

class ConversationService {
  static Future<List<Map<String, dynamic>>> getConversations(
      String userId) async {
    final url = Uri.parse('${Config.apiURL}api/conversations/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }
}
