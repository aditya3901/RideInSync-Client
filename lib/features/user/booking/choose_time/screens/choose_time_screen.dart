import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/booking/choose_time/controllers/timeslot_controller.dart';

class ChooseTimeScreen extends StatefulWidget {
  const ChooseTimeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  final timeslotController = Get.put(TimeslotController());

  @override
  void initState() {
    super.initState();
    timeslotController.getAllTimeslots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Login / Logout Time',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: timeslotController.timeslots.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                    child: RadioListTile<String>(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            timeslotController.timeslots[index].time!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.chair_rounded,
                                size: 20,
                                color: Colors.black26,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${(timeslotController.timeslots[index].booked! / timeslotController.timeslots[index].total! * 100).toStringAsFixed(0)} %",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      value: timeslotController.timeslots[index].sId!,
                      groupValue: timeslotController.selectedTimeslot.value,
                      onChanged: (value) {
                        setState(() {
                          timeslotController.selectedTimeslot.value = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  timeslotController.onNextClick();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
