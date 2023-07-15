import 'package:cinepass_user/screens/screen_signup.dart';
import 'package:cinepass_user/utils/colors.dart';
import 'package:cinepass_user/utils/sized_boxes.dart';
import 'package:cinepass_user/utils/text_styles.dart';
import 'package:cinepass_user/view_models/login_screen_viewmodel.dart';
import 'package:cinepass_user/widgets/cine_pass_button.dart';
import 'package:cinepass_user/widgets/cine_pass_loading.dart';
import 'package:cinepass_user/widgets/cine_pass_logo.dart';
import 'package:cinepass_user/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emialController = TextEditingController();
  final passwordController = TextEditingController();
  final loginPageController = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBoxHeight80,
                Align(
                    alignment: Alignment.center,
                    child: Text('Welcome Back !', style: loginPageTextStyle)),
                sizedBoxHeight70,
                const CinePassLogo(),
                sizedBoxHeight50,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CinePassTextFormField(
                          hint: 'Enter Email',
                          prefixIcon: const Icon(Icons.mail_rounded, size: 25),
                          fieldName: 'Email',
                          controller: emialController),
                      sizedBoxHeight20,
                      CinePassPasswordTextFormField(
                          hint: 'Enter Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            size: 25,
                          ),
                          passwordController: passwordController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              forgotPasswordPopup(context);
                            },
                            child: const Text('Forgot Password?')),
                      )
                    ],
                  ),
                ),
                sizedBoxHeight80,
                CinePassButton(
                    function: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const CinePassLoading();
                          },
                        );
                        await loginPageController.signinButtonClicked(context,
                            emialController.text, passwordController.text);
                      }
                    },
                    text: 'Sign In'),
                sizedBoxHeight80,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.off(SignUpScreen());
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        child: const Text('Sign Up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> forgotPasswordPopup(BuildContext context) async {
    final forgotMailController = TextEditingController();
    final forgotOtpController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
              contentPadding: EdgeInsets.all(Adaptive.h(2)),
              backgroundColor: backgroundColor,
              title: const Text('Forgot Password ?',
                  style: TextStyle(color: Colors.white)),
              children: [
                CinePassTextFormField(
                    hint: 'Enter Email',
                    fieldName: 'Email',
                    prefixIcon: const Icon(Icons.mail),
                    controller: forgotMailController),
                sizedBoxHeight30,
                CinePassButton(function: () {}, text: 'Submit'),
                sizedBoxHeight30,
                Pinput(
                    controller: forgotOtpController,
                    length: 6,
                    obscureText: true,
                    defaultPinTheme: defaultPinTheme),
                sizedBoxHeight40,
                CinePassButton(function: () {}, text: 'Verify')
              ],
            ));
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
