import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_firebase_cli/screens/opt_screen.dart';
import 'package:learn_firebase_cli/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool _iSignedIn = false;
  bool get iSignedIn => _iSignedIn;
  final isLoading = false.obs;

  String? _uid;
  String get uid => _uid!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthController() {
    checkSign();
  }

  void checkSign() async {
    final pref = SharedPreferences.getInstance();
    final SharedPreferences s = await SharedPreferences.getInstance();
    _iSignedIn = s.getBool('is_signedin') ?? false;
    debugPrint('Work here ');
  }

  void singInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Get.to(
            OtpScreen(verificationId: verificationId),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp

  void verifyOtp({
    required BuildContext context,
    required String verificationID,
    required String userOtp,
    required Function onSucess,
  }) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSucess();
      }
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      isLoading.value = false;
    }
  }
}
