import 'package:get/get.dart';

class DateController extends GetxController {
  final isLogIn = true.obs;
  var today = DateTime.now().obs;

  void toggleLoginState(int index) {
    if ((index == 0 && !isLogIn.value) || (index == 1 && isLogIn.value)) {
      isLogIn.value = !isLogIn.value;
    }
  }

  void onDaySelected(DateTime selectedDay) {
    today.value = selectedDay;
  }
}
