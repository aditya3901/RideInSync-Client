import 'dart:convert';

import 'package:get/get.dart';
import 'package:rideinsync_client/models/office_model.dart';
import 'package:rideinsync_client/models/timeslot_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController extends GetxController {
  bool? isLogin;
  DateTime? selectedDate;
  OfficeModel? selectedOffice;
  TimeslotModel? selectedTimeslot;
  final selectedLocation = ''.obs;

  final primaryLocation = Rx<Location?>(null);
  final secondaryLocation = Rx<Location?>(null);
  final isLoading = true.obs;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString("user")!));

    primaryLocation.value = userModel.user!.primaryAddress;
    secondaryLocation.value = userModel.user!.secondaryAddress;

    isLoading.value = false;
  }
}
