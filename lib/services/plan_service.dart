import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/config.dart';

class PlanService {
  static Future<bool> createPlan(Map<String, dynamic> planData) async {
    final url = Uri.parse('${Config.apiURL}api/plan/add');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(planData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Failed to create plan: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error creating plan: $e');
      return false;
    }
  }
}
