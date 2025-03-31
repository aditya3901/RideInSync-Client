import 'dart:convert';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/google_location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController {
  var primaryLocation = <String, dynamic>{}.obs;
  var secondaryLocation = <String, dynamic>{}.obs;
  var isLoading = true.obs;

  final _locationService = locator<GoogleLocationService>();

  Future<void> getUserAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString('user')!));

    final primaryResponse =
        await _locationService.getUserLocation(userModel.token!, 'primary');
    final secondaryResponse =
        await _locationService.getUserLocation(userModel.token!, 'secondary');

    if (primaryResponse["address"] != null) {
      primaryLocation.value = primaryResponse["address"];

      final primary = Location(
        type: "Point",
        address: primaryLocation["address"],
        landmark: primaryLocation["landmark"],
        placeId: primaryLocation["place_id"],
        coordinates: [
          primaryLocation["coordinates"][0],
          primaryLocation["coordinates"][1],
        ],
      );
      userModel.user!.primaryAddress = primary;
    }

    if (secondaryResponse["address"] != null) {
      secondaryLocation.value = secondaryResponse["address"];

      final secondary = Location(
        type: "Point",
        address: secondaryLocation["address"],
        landmark: secondaryLocation["landmark"],
        placeId: secondaryLocation["place_id"],
        coordinates: [
          secondaryLocation["coordinates"][0],
          secondaryLocation["coordinates"][1],
        ],
      );
      userModel.user!.secondaryAddress = secondary;
    }

    prefs.setString("user", jsonEncode(userModel.toJson()));
    isLoading.value = false;
  }
}
