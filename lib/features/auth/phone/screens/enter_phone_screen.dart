import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/auth/phone/controllers/phone_controller.dart';
import '../widgets/phone_input_field.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({Key? key}) : super(key: key);

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  final _phoneController = TextEditingController();
  final _controller = Get.put(PhoneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "What’s your Phone Number?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "You'll receive an OTP to complete your verification.",
              style: TextStyle(
                color: Color(0xFF626A8E),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            phoneInputField(
              ' Your phone number',
              TextInputType.phone,
              _phoneController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.gotoVerifyOTPScreen(_phoneController.text);
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
