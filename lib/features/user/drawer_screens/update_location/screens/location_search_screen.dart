import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/drawer_screens/update_location/screens/locate_on_map.dart';
import '../controllers/location_autocomplete_controller.dart';

class LocationSearchScreen extends StatelessWidget {
  final controller = Get.put(LocationAutoCompleteController());

  LocationSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Location',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller.searchController,
                onChanged: controller.onSearchChanged,
                decoration: InputDecoration(
                  hintText: "Search for a location...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = controller.suggestions[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      horizontalTitleGap: 0,
                      title: Text(
                        suggestion["main"] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        suggestion["secondary"] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      leading: const Icon(Icons.location_on),
                      onTap: () => controller.onSuggestionTap(
                        suggestion["place_id"],
                      ),
                    );
                  },
                );
              }),
              ListTile(
                onTap: () => Get.to(() => const LocateOnMapScreen()),
                title: const Text(
                  "Set location on map",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                leading: const Icon(Icons.pin_drop),
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
