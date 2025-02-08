import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/choose_date/screens/book_schedule_screen.dart';
import 'package:rideinsync_client/features/user/drawer/screens/user_drawer.dart';
import '../widgets/ride_card.dart';

class UserScheduleRides extends StatefulWidget {
  const UserScheduleRides({Key? key}) : super(key: key);

  @override
  State<UserScheduleRides> createState() => _UserScheduleRidesState();
}

class _UserScheduleRidesState extends State<UserScheduleRides> {
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
      body: Column(
        children: [
          RideCard(),
          RideCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const BookScheduleScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
