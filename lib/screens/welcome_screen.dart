import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learn_firebase_cli/screens/register_screen.dart';

import '../controller/auth_controller.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final ap = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/undraw_mobile_encryption.svg',
                  height: 250,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Let`s get started',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Never a bettee time than now to start.',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {
                      debugPrint('------------- is working ${ap.iSignedIn}');
                      ap.iSignedIn == true
                          ? Get.to(const HomeScren())
                          : Get.to(const RegisterScreen());
                    },
                    text: 'Get started',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
