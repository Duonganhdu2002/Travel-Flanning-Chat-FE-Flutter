import 'dart:convert';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PlaceService {
  static List<BestPlacesModel>? _cachedBestPlaces;
  
  static Future<List<BestPlacesModel>> getBestPlaces() async {
    // Kiểm tra nếu dữ liệu đã được lưu trong cache
    if (_cachedBestPlaces != null) {
      return _cachedBestPlaces!;
    }

    final url = Uri.parse('${Config.apiURL}${Config.bestPlace}');
    final response = await http.get(url);

    debugPrint("Get best places response status: ${response.statusCode}");
    debugPrint("Get best places response body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _cachedBestPlaces =
          data.map((item) => BestPlacesModel.fromJson(item)).toList();
      return _cachedBestPlaces!;
    } else {
      throw Exception('Failed to load best places');
    }
  }

  static Future<DetailPlaceModel> getPlaceDetail(String detailPlaceData) async {
    final url = Uri.parse('${Config.apiURL}/api/places/places-detail/$detailPlaceData');
    final response = await http.get(url);

    debugPrint("Get place detail response status: ${response.statusCode}");
    debugPrint("Get place detail response body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return DetailPlaceModel.fromJson(data);
    } else {
      throw Exception('Failed to load place detail');
    }
  }
}
