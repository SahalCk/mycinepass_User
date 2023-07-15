import 'package:cinepass_user/utils/colors.dart';
import 'package:cinepass_user/utils/sized_boxes.dart';

import 'package:cinepass_user/view_models/signup_screen_viewmodel.dart';
import 'package:cinepass_user/widgets/cine_pass_button.dart';
import 'package:cinepass_user/widgets/cine_pass_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  final pinController = TextEditingController();
  final otpController = Get.find<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBoxHeight90,
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    height: Adaptive.h(40),
                    child: LottieBuilder.asset(
                        'animations/otpscreen_animation.json')),
              ),
              sizedBoxHeight80,
              const Text('Enter Your OTP',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text('OTP has sent to ${otpController.userModel.email}',
                  style: TextStyle(color: primaryColor)),
              sizedBoxHeight30,
              Pinput(
                controller: pinController,
                length: 6,
                obscureText: true,
                defaultPinTheme: defaultPinTheme,
              ),
              TextButton(
                  onPressed: () {
                    otpController.resendOTP(
                        context, otpController.userModel.email);
                  },
                  child: const Text('Resend OTP')),
              sizedBoxHeight70,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Adaptive.w(4)),
                child: CinePassButton(
                    function: () {
                      showDialog(
                          context: context,
                          builder: (context) => const CinePassLoading());
                      otpController.otpSubmitButtonClicked(
                          context, pinController.text);
                    },
                    text: 'Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 233, 233),
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(10),
      ));
}
