import 'package:get/get.dart';
import 'package:rideinsync_client/features/auth/otp/screens/verify_otp_screen.dart';

class PhoneController extends GetxController {
  void gotoVerifyOTPScreen(String phoneNumber) {
    if (phoneNumber.isNotEmpty && phoneNumber.length == 10) {
      Get.offAll(() => VerifyOTPScreen(phoneNumber: phoneNumber));
    }
  }
}
