import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/booking/choose_home/controllers/booking_controller.dart';
import 'package:rideinsync_client/features/user/booking/choose_office/screens/choose_office_screen.dart';

class DateController extends GetxController {
  final isLogIn = true.obs;
  var today = DateTime.now().obs;

  final _bookingController = Get.put(BookingController());

  void toggleLoginState(int index) {
    if ((index == 0 && !isLogIn.value) || (index == 1 && isLogIn.value)) {
      isLogIn.value = !isLogIn.value;
    }
  }

  void onDaySelected(DateTime selectedDay) {
    today.value = selectedDay;
  }

  void onNextClick() {
    _bookingController.isLogin = isLogIn.value;
    _bookingController.selectedDate = today.value;

    Get.to(() => const ChooseOfficeScreen());
  }
}
