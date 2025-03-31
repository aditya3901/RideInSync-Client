import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/home/schedule_ride/screens/schedule_rides_screen.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/google_location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAddressController extends GetxController {
  String? locationType;
  LatLng? currentPosition;
  var addressController = TextEditingController();
  var landmarkController = TextEditingController();
  Map<String, dynamic> selectedLocation = {};

  final _locationService = locator<GoogleLocationService>();

  void submitUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(
      jsonDecode(prefs.getString("user")!),
    );

    selectedLocation["address"] = addressController.text;
    selectedLocation["landmark"] = landmarkController.text;
    selectedLocation["type"] = locationType;

    final response = await _locationService.setUserLocation(
      userModel.token!,
      selectedLocation,
    );

    if (response["status"] == "success") {
      final location = Location(
        type: "Point",
        address: selectedLocation["address"],
        landmark: selectedLocation["landmark"],
        placeId: selectedLocation["place_id"],
        coordinates: [selectedLocation["lng"], selectedLocation["lat"]],
      );

      if (locationType == 'primary') {
        userModel.user!.primaryAddress = location;
      } else {
        userModel.user!.secondaryAddress = location;
      }

      prefs.setString("user", jsonEncode(userModel.toJson()));
    } else {
      Get.snackbar(
        "Error",
        "Failed to update location, please try again!",
      );
    }

    Get.offAll(() => const UserScheduleRides());
  }
}
