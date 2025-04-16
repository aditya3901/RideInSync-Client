import 'dart:convert';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/home/schedule_ride/screens/schedule_rides_screen.dart';
import 'package:rideinsync_client/models/office_model.dart';
import 'package:rideinsync_client/models/timeslot_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  bool? isLogin;
  DateTime? selectedDate;
  OfficeModel? selectedOffice;
  TimeslotModel? selectedTimeslot;
  final selectedLocation = ''.obs;

  final primaryLocation = Rx<Location?>(null);
  final secondaryLocation = Rx<Location?>(null);
  final isLoading = true.obs;
  late UserModel? userModel;

  final _bookingService = locator<BookingService>();

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(jsonDecode(prefs.getString("user")!));

    primaryLocation.value = userModel!.user!.primaryAddress;
    secondaryLocation.value = userModel!.user!.secondaryAddress;

    isLoading.value = false;
  }

  Future<void> bookRide() async {
    try {
      isLoading.value = true;

      if (selectedLocation.value.isEmpty) {
        Get.snackbar(
          'Error',
          'Please select a pickup location',
        );
        return;
      }

      final response = await _bookingService.bookRide(
        token: userModel!.token!,
        isLogin: isLogin!,
        date: selectedDate.toString().split(' ')[0],
        officeId: selectedOffice!.sId!,
        timeslotId: selectedTimeslot!.sId!,
        homeType: selectedLocation.value,
      );

      if (response['status'] == 'success') {
        Get.offAll(() => const UserScheduleRides());
        Get.snackbar(
          'Success',
          'Ride booked successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Failed to book ride',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
