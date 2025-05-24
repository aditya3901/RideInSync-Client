import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/booking/choose_home/controllers/booking_controller.dart';
import 'package:rideinsync_client/features/user/booking/choose_time/screens/choose_time_screen.dart';
import 'package:rideinsync_client/models/office_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfficeController extends GetxController {
  var officeList = List<OfficeModel>.empty().obs;
  final selectedItem = ''.obs;

  final _bookingService = locator<BookingService>();
  final _bookingController = Get.put(BookingController());

  Future<void> getAllOffice() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString('user')!));

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Location Permission Denied",
          "Please enable location permissions",
        );
        return;
      }
    }
    final currentPosition = await Geolocator.getCurrentPosition();

    final officeResponse = await _bookingService.getNearbyOffice(
      companyId: userModel.user!.company!,
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );

    if (officeResponse["status"] == "success") {
      officeList.value = List<OfficeModel>.from(
        officeResponse["offices"].map(
          (officeJson) => OfficeModel.fromJson(officeJson),
        ),
      );
    }
  }

  void onNextClick() {
    if (selectedItem.isNotEmpty) {
      _bookingController.selectedOffice = officeList.firstWhere(
        (element) => element.sId == selectedItem.value,
      );

      Get.to(() => const ChooseTimeScreen());
    } else {
      Get.snackbar(
        'Error',
        'Please select an office',
      );
    }
  }
}
