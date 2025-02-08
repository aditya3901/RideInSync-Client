import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rideinsync_client/features/auth/register/controllers/register_controller.dart';
import '../widgets/input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controller = Get.put(RegisterController());

  final type = TextEditingController(text: "user");
  final _nameController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _vehicleNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _controller.isLoading.value,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Setup your RideInSync Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.16,
                      ),
                    ),
                    const Text(
                      "Your name helps us to get to know you & make\nyour ride a smoother experience...",
                      style: TextStyle(
                        color: Color(0xFF626A8E),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    const Text(
                      'What should we call you?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    inputField(
                      "Enter your name",
                      TextInputType.text,
                      _nameController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'How do you want to join us?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type.text = "user";
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: type.text == "user"
                              ? Colors.deepOrangeAccent
                              : Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          'Customer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type.text = "driver";
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: type.text == "driver"
                              ? Colors.deepOrangeAccent
                              : Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          'Driver',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    type.text == "driver"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Enter your vehicle details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              inputField(
                                "Enter your vehicle model",
                                TextInputType.text,
                                _vehicleModelController,
                              ),
                              inputField(
                                "Enter your vehicle number",
                                TextInputType.text,
                                _vehicleNumberController,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.register(
            name: _nameController.text,
            vehicleModel: _vehicleModelController.text,
            vehicleNumber: _vehicleNumberController.text,
            type: type.text,
          );
        },
        backgroundColor:
            type.text == "" ? Colors.grey : Colors.deepOrangeAccent,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
