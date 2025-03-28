import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/controllers/edit_address_controller.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/screens/edit_address_screen.dart';
import 'package:rideinsync_client/services/google_location_service.dart';

class LocationAutoCompleteController extends GetxController {
  final _locationService = locator<GoogleLocationService>();
  final editAddressController = Get.put(EditAddressController());

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

  void onSuggestionTap(String placeId) async {
    final selectedLocation = await _locationService.fetchPlaceDetails(placeId);

    editAddressController.selectedLocation = selectedLocation!;
    editAddressController.addressController.text = selectedLocation['address'];
    editAddressController.currentPosition = LatLng(
      selectedLocation['lat'],
      selectedLocation['lng'],
    );

    Get.to(() => const EditAddressPage());
  }
}
