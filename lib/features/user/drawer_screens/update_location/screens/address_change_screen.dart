import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/address_controller.dart';
import '../widgets/address_card.dart';

class AddressChangeScreen extends StatefulWidget {
  @override
  State<AddressChangeScreen> createState() => _AddressChangeScreenState();
}

class _AddressChangeScreenState extends State<AddressChangeScreen> {
  final controller = Get.put(AddressController());

  @override
  void initState() {
    super.initState();
    controller.getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Address Change',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.primaryLocation.isEmpty
                          ? AddressCard(
                              type: "primary",
                              title: "Primary Address",
                              address: "Please set your primary address",
                              geocode: '0.0, 0.0',
                              shuttleStop: "-- --",
                            )
                          : AddressCard(
                              type: "primary",
                              title: "Primary Address",
                              address: controller.primaryLocation["address"],
                              geocode:
                                  '${controller.primaryLocation['coordinates'][1]}, ${controller.primaryLocation['coordinates'][0]}',
                              shuttleStop: "-- --",
                            ),
                      const SizedBox(height: 16),
                      controller.secondaryLocation.isEmpty
                          ? AddressCard(
                              type: "secondary",
                              title: "Secondary Address",
                              address: "Please set your secondary address",
                              geocode: '0.0, 0.0',
                              shuttleStop: "-- --",
                            )
                          : AddressCard(
                              type: "secondary",
                              title: "Secondary Address",
                              address: controller.secondaryLocation["address"],
                              geocode:
                                  '${controller.secondaryLocation['coordinates'][1]}, ${controller.secondaryLocation['coordinates'][0]}',
                              shuttleStop: "-- --",
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
