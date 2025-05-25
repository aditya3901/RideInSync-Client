import 'dart:convert';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/booking/choose_date/screens/choose_date_screen.dart';
import 'package:rideinsync_client/models/ride_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RidesController extends GetxController {
  final _bookingService = locator<BookingService>();
  final isLoading = true.obs;
  RxList<RideModel> rides = <RideModel>[].obs;

  void scheduleRide() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString("user")!));

    if (userModel.user!.primaryAddress != null &&
        userModel.user!.secondaryAddress != null) {
      Get.to(() => const ChooseDateScreen());
    } else {
      Get.snackbar(
        "Error",
        "Please add your primary and secondary address before scheduling a ride",
      );
    }
  }

  Future<void> getRides() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString("user")!));

    final response = await _bookingService.getUserRides(
      token: userModel.token!,
    );

    if (response['status'] == 'success' && response['results'] != 0) {
      final List<dynamic> ridesData = response['data']['rides'];
      final List<RideModel> rideList =
          ridesData.map((ride) => RideModel.fromJson(ride)).toList();
      rides.value = rideList;
    }

    isLoading.value = false;
  }
}
