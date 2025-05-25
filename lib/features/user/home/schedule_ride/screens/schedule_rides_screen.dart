import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/drawer/screens/user_drawer.dart';
import '../controllers/rides_controller.dart';
import '../widgets/ride_card.dart';

class UserScheduleRides extends StatefulWidget {
  const UserScheduleRides({Key? key}) : super(key: key);

  @override
  State<UserScheduleRides> createState() => _UserScheduleRidesState();
}

class _UserScheduleRidesState extends State<UserScheduleRides> {
  final _controller = Get.put(RidesController());

  @override
  void initState() {
    super.initState();
    _controller.getRides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserDrawer(),
      appBar: AppBar(
        title: const Text(
          'Schedules',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_controller.rides.isEmpty) {
          return const Center(child: Text("No rides found"));
        }
        return ListView.builder(
          itemCount: _controller.rides.length,
          itemBuilder: (context, index) {
            final ride = _controller.rides[index];
            return RideCard(ride: ride);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.scheduleRide();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
