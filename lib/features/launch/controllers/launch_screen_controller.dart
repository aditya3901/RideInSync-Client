import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/auth/docs/screens/document_screen.dart';
import 'package:rideinsync_client/features/auth/phone/screens/enter_phone_screen.dart';
import 'package:rideinsync_client/features/user/home/schedule_ride/screens/schedule_rides_screen.dart';
import 'package:rideinsync_client/models/driver_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/common_auth_service.dart';
import 'package:rideinsync_client/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchScreenController extends GetxController {
  var isLoading = false.obs;

  final _firebaseService = locator<FirebaseService>();
  final _commonAuthService = locator<CommonAuthService>();

  Future<void> googleSignIn() async {
    isLoading(true);

    String? email = await _firebaseService.googleSignIn();
    if (email != null) {
      final emailResponse = await _commonAuthService.verifyEmail(email);
      if (emailResponse['status'] == 'success') {
        login(emailResponse['type'], email);
      } else {
        Get.offAll(() => const EnterPhoneScreen());
      }
    }

    isLoading(false);
  }

  Future<void> login(String type, String email) async {
    final androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    String deviceId = androidDeviceInfo.id;
    String deviceType = 'android';
    final deviceFCMToken = await FirebaseMessaging.instance.getToken();

    final reqBody = {
      'email': email,
      'deviceID': deviceId,
      'deviceType': deviceType,
      'deviceToken': deviceFCMToken,
    };

    final loginResponse = await _commonAuthService.login(type, reqBody);
    final prefs = await SharedPreferences.getInstance();

    if (type == 'user') {
      final userModel = UserModel.fromJson(loginResponse);
      prefs.setString("user", jsonEncode(userModel.toJson()));

      if (userModel.user!.verified!) {
        Get.offAll(() => const UserScheduleRides());
      } else {
        Get.offAll(() => const DocumentScreen(userType: "user"));
      }
    } else {
      final driverModel = DriverModel.fromJson(loginResponse);
      prefs.setString("driver", jsonEncode(driverModel.toJson()));

      if (driverModel.driver!.verified!) {
        // Get to Driver Home
      } else {
        Get.offAll(() => const DocumentScreen(userType: "driver"));
      }
    }
  }
}
