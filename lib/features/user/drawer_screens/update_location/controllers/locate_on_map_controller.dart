import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideinsync_client/configure_dependency.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/controllers/edit_address_controller.dart';
import 'package:rideinsync_client/services/google_location_service.dart';
import '../screens/edit_address_screen.dart';

class LocateOnMapController extends GetxController {
  final _locationService = locator<GoogleLocationService>();
  final editAddressController = Get.put(EditAddressController());

  var currentPosition = Rx<LatLng?>(null);
  var currentAddress = Rx<Map<String, dynamic>?>(null);
  var markers = <Marker>{}.obs;

  Future<void> determineInitPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Location Service Disabled",
        "Please enable location services",
      );
      return;
    }

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

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    await Geolocator.getCurrentPosition().then((position) {
      setMarker(LatLng(position.latitude, position.longitude));
    });
  }

  void setMarker(LatLng position) async {
    currentPosition.value = position;

    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: position,
      ),
    );
    markers.refresh();

    currentAddress.value = await _locationService.fetchAddressFromLatLng(
      position.latitude,
      position.longitude,
    );
  }

  void onLocationSelected() {
    editAddressController.currentPosition = currentPosition.value!;
    editAddressController.selectedLocation = currentAddress.value!;
    editAddressController.addressController.text =
        currentAddress.value!['address'];

    Get.to(() => const EditAddressPage());
  }
}
