import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/controllers/locate_on_map_controller.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/screens/edit_address_screen.dart';

class LocateOnMapScreen extends StatefulWidget {
  const LocateOnMapScreen({Key? key}) : super(key: key);

  @override
  State<LocateOnMapScreen> createState() => _LocateOnMapScreenState();
}

class _LocateOnMapScreenState extends State<LocateOnMapScreen> {
  final controller = Get.put(LocateOnMapController());

  @override
  void initState() {
    super.initState();
    controller.determineInitPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Locate On Map',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.currentPosition.value == null ||
                  controller.markers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: controller.currentPosition.value!,
                  zoom: 15.0,
                ),
                markers: controller.markers,
                onTap: (LatLng position) {
                  controller.setMarker(position);
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Primary Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  if (controller.currentAddress.value == null) {
                    return const Text("Fetching...");
                  }
                  return Text(
                    controller.currentAddress.value!["address"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
                const SizedBox(height: 8),
                const Text(
                  "Geocode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  if (controller.currentPosition.value == null) {
                    return const Text("Fetching...");
                  }
                  return Text(
                      "${controller.currentPosition.value!.latitude.toStringAsFixed(6)}, ${controller.currentPosition.value!.longitude.toStringAsFixed(6)}");
                }),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Change only Geocode"),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        activeColor: Colors.deepOrangeAccent,
                        value: false,
                        onChanged: (bool value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => EditAddressPage());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
