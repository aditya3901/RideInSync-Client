import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import 'package:rideinsync_client/features/auth/register/screens/register_screen.dart';
import '../controllers/otp_controller.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyOTPScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _controller = Get.put(OTPController());

  @override
  void initState() {
    super.initState();

    _controller.phoneAuth(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6fb),
      resizeToAvoidBottomInset: false,
      body: Obx(() => ModalProgressHUD(
            inAsyncCall: _controller.isLoading.value,
            child: Scaffold(
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
                      'Enter your OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.16,
                      ),
                    ),
                    const Text(
                      "Enter the 6-digit OTP code to complete verification.",
                      style: TextStyle(
                        color: Color(0xFF626A8E),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pinput(
                          length: 6,
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(31, 110, 110, 110),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onCompleted: (pin) {
                            _controller.verifyOTP(widget.phoneNumber, pin);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
