import 'package:get/get.dart';
import 'package:rideinsync_client/models/office_model.dart';
import 'package:rideinsync_client/models/timeslot_model.dart';
import 'package:rideinsync_client/models/user_model.dart';

class BookingController extends GetxController {
  bool? isLogin;
  OfficeModel? selectedOffice;
  TimeslotModel? selectedTimeslot;
  Location? selectedLocation;
  DateTime? selectedDate;
}
