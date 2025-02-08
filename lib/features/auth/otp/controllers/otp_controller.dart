import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/auth/register/screens/register_screen.dart';
import 'package:rideinsync_client/features/launch/screens/launch_screen.dart';
import 'package:rideinsync_client/services/firebase_service.dart';

class OTPController extends GetxController {
  var isLoading = false.obs;
  final _firebaseService = locator<FirebaseService>();

  Future<void> phoneAuth(String phoneNumber) async {
    await _firebaseService.phoneAuth(phoneNumber);
  }

  Future<void> verifyOTP(String phoneNumber, String otp) async {
    isLoading.value = true;

    final verified = await _firebaseService.verifyOTP(otp);
    if (verified == true) {
      Get.offAll(() => const RegisterScreen());
    } else {
      Get.snackbar(
        'Invalid OTP',
        'Verification failed! Please try again.',
      );

      Get.offAll(() => const LaunchScreen());
    }
  }
}
