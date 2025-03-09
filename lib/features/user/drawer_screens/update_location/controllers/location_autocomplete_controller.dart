import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/services/location_autocomplete_service.dart';

class LocationAutoCompleteController extends GetxController {
  final _locationService = locator<LocationAutoCompleteService>();

  var suggestions = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final searchController = TextEditingController();

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      suggestions.clear();
      return;
    }

    _locationService.debounce((q) async {
      isLoading.value = true;
      suggestions.value = await _locationService.fetchPlaceSuggestions(q);
      isLoading.value = false;
    }, query);
  }

  Future<Map<String, dynamic>?> fetchLocationDetails(String placeId) async {
    return await _locationService.fetchPlaceDetails(placeId);
  }
}
