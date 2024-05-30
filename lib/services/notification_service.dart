import 'dart:convert';
import 'package:flutter_app/config.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static Future<List<Map<String, dynamic>>> getUserNotifications(
      String userId) async {
    final url = Uri.parse('${Config.apiURL}/api/notifications/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) {
        return {
          'id': item['_id'],
          'message': item['message'],
          'isRead': item['isRead'].toString(),
          'createdAt': item['createdAt']
        };
      }).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    final url = Uri.parse('${Config.apiURL}/api/notifications/$notificationId');
    final response = await http.patch(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to mark notification as read');
    }
  }
}
