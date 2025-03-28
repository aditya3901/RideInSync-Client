import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rideinsync_client/core/constants/api_url.dart';

class GoogleLocationService {
  final Duration debounceDuration = const Duration(milliseconds: 500);
  Timer? _debounceTimer;
  final Map<String, List<Map<String, dynamic>>> _cache = {};

  Future<List<Map<String, dynamic>>> fetchPlaceSuggestions(String query) async {
    if (query.isEmpty) return [];

    if (_cache.containsKey(query)) {
      return _cache[query]!;
    }

    final response = await http.get(
      Uri.parse("${ApiUrl.googleAutoComplete}$query"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "OK") {
        List<Map<String, dynamic>> suggestions = data["predictions"]
            .map<Map<String, dynamic>>((item) => {
                  "main": item["structured_formatting"]["main_text"],
                  "secondary": item["structured_formatting"]["secondary_text"],
                  "place_id": item["place_id"],
                })
            .toList();

        _cache[query] = suggestions;
        return suggestions;
      }
    }
    return [];
  }

  Future<Map<String, dynamic>?> fetchPlaceDetails(String placeId) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.googlePlaceDetails}$placeId"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "OK") {
        final location = data["result"]["geometry"]["location"];
        return {
          "lat": location["lat"],
          "lng": location["lng"],
          "address": data["result"]["formatted_address"],
          "place_id": placeId,
        };
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchAddressFromLatLng(
    double lat,
    double lng,
  ) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.googleGeocode}$lat,$lng"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "OK") {
        final result = data["results"][0];
        return {
          "lat": lat,
          "lng": lng,
          "address": result["formatted_address"],
          "place_id": result["place_id"],
        };
      }
    }

    return null;
  }

  void debounce(Function callback, String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounceDuration, () => callback(query));
  }

  Future<Map<String, dynamic>> setUserLocation(
    String token,
    Map<String, dynamic> location,
  ) async {
    final response = await http.post(
      Uri.parse(ApiUrl.userAddress),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(location),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getUserLocation(
      String token, String type) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.userAddress}?type=$type'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    return jsonDecode(response.body);
  }
}
