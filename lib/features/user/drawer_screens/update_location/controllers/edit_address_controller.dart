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
    final user = UserModel.fromJson(
      jsonDecode(prefs.getString("user")!),
    );

    selectedLocation["address"] = addressController.text;
    selectedLocation["landmark"] = landmarkController.text;
    selectedLocation["type"] = locationType;

    await _locationService.setUserLocation(
      user.token!,
      selectedLocation,
    );

    Get.offAll(() => const UserScheduleRides());
  }
}
