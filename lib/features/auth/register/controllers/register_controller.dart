import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/auth/docs/screens/document_screen.dart';
import 'package:rideinsync_client/features/launch/screens/launch_screen.dart';
import 'package:rideinsync_client/models/driver_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/common_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final _authService = locator<CommonAuthService>();

  Future<void> register({
    required String name,
    required String vehicleModel,
    required String vehicleNumber,
    required String type,
  }) async {
    isLoading.value = true;

    final androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    String deviceId = androidDeviceInfo.id;
    String deviceType = 'android';
    final deviceFCMToken = await FirebaseMessaging.instance.getToken();

    final user = FirebaseAuth.instance.currentUser;

    final reqBody = {
      'name': name,
      'email': user!.email,
      'mobile': user.phoneNumber,
      'deviceId': deviceId,
      'deviceType': deviceType,
      'deviceToken': deviceFCMToken,
    };

    if (type == 'driver') {
      reqBody['vehicle_model'] = vehicleModel;
      reqBody['vehicle_number'] = vehicleNumber;
    }

    final registerResponse = await _authService.register(type, reqBody);

    if (registerResponse['status'] == 'fail') {
      Get.snackbar(
        'Duplicate mobile number',
        'User with the same mobile already exists.',
      );

      Get.offAll(() => const LaunchScreen());
    } else {
      final prefs = await SharedPreferences.getInstance();
      if (type == 'user') {
        final user = UserModel.fromJson(registerResponse);
        prefs.setString("user", jsonEncode(user.toJson()));
      } else {
        final driver = DriverModel.fromJson(registerResponse);
        prefs.setString("driver", jsonEncode(driver.toJson()));
      }

      Get.offAll(() => DocumentScreen(userType: type));
    }
  }
}
