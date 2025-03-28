import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/controllers/edit_address_controller.dart';
import '../screens/location_search_screen.dart';

class AddressCard extends StatelessWidget {
  final String type;
  final String title;
  final String address;
  final String geocode;
  final String shuttleStop;

  AddressCard({
    Key? key,
    required this.type,
    required this.title,
    required this.address,
    required this.geocode,
    required this.shuttleStop,
  }) : super(key: key);

  final editAddressController = Get.put(EditAddressController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    editAddressController.locationType = type;
                    Get.to(() => LocationSearchScreen());
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.deepOrangeAccent,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Address",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(address, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            const Text(
              "Geocode",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(geocode, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            const Text(
              "Shuttle Stop",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(shuttleStop, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
