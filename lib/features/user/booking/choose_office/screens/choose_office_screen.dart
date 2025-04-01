import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../choose_time/screens/choose_time_screen.dart';
import '../controllers/office_controller.dart';

class ChooseOfficeScreen extends StatefulWidget {
  const ChooseOfficeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseOfficeScreen> createState() => _ChooseOfficeScreenState();
}

class _ChooseOfficeScreenState extends State<ChooseOfficeScreen> {
  final controller = Get.put(OfficeController());
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    controller.getAllOffice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Login Office',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black54,
      ),
      body: Obx(
        () => controller.officeList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.officeList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                          child: RadioListTile<String>(
                            title: Text(
                              controller.officeList[index].name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: controller.officeList[index].sId!,
                            groupValue: _selectedItem,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value;
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const ChooseTimeScreen());
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
