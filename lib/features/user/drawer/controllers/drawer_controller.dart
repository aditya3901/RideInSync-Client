import 'dart:convert';
import 'package:get/get.dart';
import 'package:rideinsync_client/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawerController extends GetxController {
  var user = Rx<UserModel?>(null);
  var isLoading = true.obs;

  void fetchUserDetails() async {
    if (user.value != null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    user.value = UserModel.fromJson(jsonDecode(userString!));

    isLoading.value = false;
  }

  void logout() {}
}
