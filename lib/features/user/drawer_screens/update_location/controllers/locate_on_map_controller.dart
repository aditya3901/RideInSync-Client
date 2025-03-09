import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateOnMapController extends GetxController {
  var currentPosition = Rx<LatLng?>(null);
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

  void setMarker(LatLng position) {
    currentPosition.value = position;
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: position,
      ),
    );
    markers.refresh();
  }
}
