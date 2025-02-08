import 'dart:convert';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/auth/docs/screens/document_screen.dart';
import 'package:rideinsync_client/features/launch/screens/launch_screen.dart';
import 'package:rideinsync_client/models/driver_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/common_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final _authService = locator<CommonAuthService>();

  void checkUserExist() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("user");
    final driverJson = prefs.getString("driver");

    if (userJson == null && driverJson == null) {
      Get.offAll(() => const LaunchScreen());
      return;
    }

    if (userJson != null) {
      final userModel = UserModel.fromJson(jsonDecode(userJson));
      final userDetailsResponse = await _authService.getDetails(
        "user",
        userModel.token!,
      );

      if (userDetailsResponse['verified'] == true) {
        // Get to User Home
      } else {
        Get.offAll(() => const DocumentScreen(userType: "user"));
      }
    } else {
      final driverModel = DriverModel.fromJson(jsonDecode(driverJson!));
      final driverDetailsResponse = await _authService.getDetails(
        "driver",
        driverModel.token!,
      );

      if (driverDetailsResponse['verified'] == true) {
        // Get to Driver Home
      } else {
        Get.offAll(() => const DocumentScreen(userType: "driver"));
      }
    }
  }
}
