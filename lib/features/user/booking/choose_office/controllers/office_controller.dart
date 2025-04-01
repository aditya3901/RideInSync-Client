import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/models/office_model.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:rideinsync_client/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfficeController extends GetxController {
  var officeList = List<OfficeModel>.empty().obs;

  final _bookingService = locator<BookingService>();

  Future<void> getAllOffice() async {
    final prefs = await SharedPreferences.getInstance();
    final userModel = UserModel.fromJson(jsonDecode(prefs.getString('user')!));

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
}
