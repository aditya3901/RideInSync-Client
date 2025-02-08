import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import '../widgets/drawer_item.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final drawerController = Get.put(UserDrawerController());

  @override
  void initState() {
    super.initState();
    drawerController.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(() {
        final userModel = drawerController.user.value;

        return userModel == null
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: Text(userModel.user!.name!),
                      subtitle: Text(userModel.user!.email!),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        height: 0,
                        thickness: 1,
                      ),
                    ),
                    const ListTile(
                      title: Text("Malad Interface 16, Mumbai"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        height: 0,
                        thickness: 1,
                      ),
                    ),
                    buildDrawerItem(
                      Icons.schedule,
                      "Book Schedule",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.calendar_today,
                      "Team Calendar",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.history,
                      "Trip History",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.edit_location,
                      "Update Pickup/Drop Point",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.help,
                      "FAQs",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.call,
                      "Call Helpdesk",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.star_rate,
                      "Rate this App",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.article,
                      "Terms of Usage",
                      null,
                    ),
                    buildDrawerItem(
                      Icons.logout,
                      "Logout",
                      null,
                      logout: true,
                      drawerController: drawerController,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        thickness: 1,
                      ),
                    ),
                    const ListTile(
                      subtitle: Text("Version 1.0.0"),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
