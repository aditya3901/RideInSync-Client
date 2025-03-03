import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/screens/edit_address_screen.dart';

class LocateOnMapScreen extends StatefulWidget {
  const LocateOnMapScreen({Key? key}) : super(key: key);

  @override
  State<LocateOnMapScreen> createState() => _LocateOnMapScreenState();
}

class _LocateOnMapScreenState extends State<LocateOnMapScreen> {
  LatLng _currentPosition = LatLng(17.452898, 78.367304);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarker(_currentPosition);
  }

  void _setMarker(LatLng position) {
    setState(() {
      _currentPosition = position;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: position,
        ),
      );
    });
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
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15.0,
              ),
              markers: _markers,
              onTap: (LatLng position) {
                _setMarker(position);
              },
            ),
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
                const Text(
                    "Manbhum - Around the Grove, White Field Rd, Ashok Nagar, Whitefields, Kondapur, Telangana 500081, India"),
                const SizedBox(height: 8),
                const Text(
                  "Geocode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${_currentPosition.latitude.toStringAsFixed(6)}, ${_currentPosition.longitude.toStringAsFixed(6)}"),
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
