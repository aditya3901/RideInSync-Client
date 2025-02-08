import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rideinsync_client/features/launch/screens/launch_screen.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var otpVerificationId = '';

  Future<String?> googleSignIn() async {
    await GoogleSignIn().signOut(); // For testing, needs to be removed

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final googleAuthentication = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuthentication.accessToken,
          idToken: googleAuthentication.idToken,
        );

        await _auth.signInWithCredential(credential);

        return googleUser.email;
      }
    } catch (_) {}

    return null;
  }

  Future<void> phoneAuth(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.currentUser?.linkWithCredential(credential);
          await _auth.currentUser?.reload();
        },
        verificationFailed: (e) {
          Get.snackbar(
            'Failed to verify OTP',
            'Something went wrong! Please try again.',
          );

          Get.offAll(() => const LaunchScreen());
        },
        codeSent: (String verificationId, int? resendToken) async {
          otpVerificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          otpVerificationId = verificationId;
        },
      );
    } catch (_) {}
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final phoneCredential = PhoneAuthProvider.credential(
        verificationId: otpVerificationId,
        smsCode: otp,
      );

      var currentUser = _auth.currentUser;
      await currentUser?.linkWithCredential(phoneCredential);
      await currentUser?.reload();

      return true;
    } catch (_) {
      return false;
    }
  }
}
