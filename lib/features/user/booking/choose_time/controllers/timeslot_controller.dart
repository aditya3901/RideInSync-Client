import 'package:get/get.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/booking/choose_home/controllers/booking_controller.dart';
import 'package:rideinsync_client/features/user/booking/choose_home/screens/choose_home_screen.dart';
import 'package:rideinsync_client/models/timeslot_model.dart';
import 'package:rideinsync_client/services/booking_service.dart';

class TimeslotController extends GetxController {
  final timeslots = List<TimeslotModel>.empty().obs;
  final selectedTimeslot = ''.obs;

  final _bookingService = locator<BookingService>();
  final _bookingController = Get.put(BookingController());

  Future<void> getAllTimeslots() async {
    final timeslotResponse = await _bookingService.getNextTimeslots(
      date: _bookingController.selectedDate.toString().split(' ')[0],
      officeId: _bookingController.selectedOffice!.sId!,
      type: _bookingController.isLogin! ? 'login' : 'logout',
      userTime: _bookingController.selectedDate.toString().split(' ')[1],
    );

    if (timeslotResponse["status"] == "success") {
      timeslots.value = List<TimeslotModel>.from(
        timeslotResponse["timeslots"].map(
          (timeslotJson) => TimeslotModel.fromJson(timeslotJson),
        ),
      );
    }
  }

  void onNextClick() {
    if (selectedTimeslot.isNotEmpty) {
      _bookingController.selectedTimeslot = timeslots.firstWhere(
        (element) => element.sId == selectedTimeslot.value,
      );

      Get.to(() => const ChooseHomeScreen());
    } else {
      Get.snackbar(
        'Error',
        'Please select a timeslot',
      );
    }
  }
}
