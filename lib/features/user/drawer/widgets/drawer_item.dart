import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';

Widget buildDrawerItem(
  IconData icon,
  String title,
  Widget? page, {
  bool logout = false,
  UserDrawerController? drawerController,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    horizontalTitleGap: 0,
    onTap: () {
      if (logout) {
        drawerController!.logout();
      } else if (page != null) {
        Get.to(() => page);
      }
    },
  );
}
