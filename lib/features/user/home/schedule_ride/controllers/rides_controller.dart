import 'dart:convert';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/booking/choose_date/screens/book_schedule_screen.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RidesController extends GetxController {
  void scheduleRide() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString("user")!));

    if (userModel.user!.primaryAddress != null &&
        userModel.user!.secondaryAddress != null) {
      Get.to(() => const BookScheduleScreen());
    } else {
      Get.snackbar(
        "Error",
        "Please add your primary and secondary address before scheduling a ride",
      );
    }
  }
}
