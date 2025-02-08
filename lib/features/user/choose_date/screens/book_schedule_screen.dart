import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/user/choose_date/controllers/date_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class BookScheduleScreen extends StatefulWidget {
  const BookScheduleScreen({Key? key}) : super(key: key);

  @override
  State<BookScheduleScreen> createState() => _BookScheduleScreenState();
}

class _BookScheduleScreenState extends State<BookScheduleScreen> {
  final dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Schedule',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Obx(
            () => ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.deepOrangeAccent,
              color: Colors.black,
              isSelected: [
                dateController.isLogIn.value,
                !dateController.isLogIn.value,
              ],
              onPressed: (index) {
                dateController.toggleLoginState(index);
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Login'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          const Text(
            'Weekly Off: Sunday',
          ),
          const SizedBox(height: 20),
          Obx(
            () => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TableCalendar(
                  locale: "en_US",
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  rowHeight: 60,
                  availableGestures: AvailableGestures.all,
                  focusedDay: dateController.today.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(day, dateController.today.value);
                  },
                  firstDay: DateTime.utc(2020, 01, 01),
                  lastDay: DateTime.utc(2050, 12, 31),
                  onDaySelected: (selectedDay, _) {
                    dateController.onDaySelected(selectedDay);
                  },
                ),
              ),
            ),
          ),
          const Spacer(),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ElevatedButton(
              onPressed: () {},
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
    );
  }
}
