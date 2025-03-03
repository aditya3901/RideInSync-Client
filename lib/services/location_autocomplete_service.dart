import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rideinsync_client/core/constants/api_url.dart';

class LocationAutoCompleteService {
  final Duration debounceDuration = const Duration(milliseconds: 500);
  Timer? _debounceTimer;
  final Map<String, List<Map<String, String>>> _cache = {};

  Future<List<Map<String, String>>> fetchPlaceSuggestions(String query) async {
    if (query.isEmpty) return [];

    if (_cache.containsKey(query)) {
      return _cache[query]!;
    }

    final response = await http.get(
      Uri.parse(ApiUrl.googleAutoComplete + query),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "OK") {
        List<Map<String, String>> suggestions = data["predictions"]
            .map<Map<String, String>>((item) => {
                  "description": item["description"],
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
      Uri.parse(ApiUrl.googlePlaceDetails + placeId),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "OK") {
        final location = data["result"]["geometry"]["location"];
        return {
          "lat": location["lat"],
          "lng": location["lng"],
          "address": data["result"]["formatted_address"],
        };
      }
    }
    return null;
  }

  void debounce(Function callback, String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(debounceDuration, () => callback(query));
  }
}
