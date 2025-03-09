import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/services/google_location_service.dart';

class LocationAutoCompleteController extends GetxController {
  final _locationService = locator<GoogleLocationService>();

  var suggestions = <Map<String, dynamic>>[].obs;
  var selectedLocation = Rx<Map<String, dynamic>?>(null);
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

  void onSuggestionTap(String placeId) async {
    selectedLocation.value = await _locationService.fetchPlaceDetails(placeId);
    searchController.text = selectedLocation.value!['address'];
  }
}
