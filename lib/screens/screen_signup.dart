import 'package:cinepass_user/models/user_model.dart';
import 'package:cinepass_user/screens/screen_signin.dart';
import 'package:cinepass_user/utils/sized_boxes.dart';
import 'package:cinepass_user/utils/text_styles.dart';
import 'package:cinepass_user/view_models/signup_screen_viewmodel.dart';
import 'package:cinepass_user/widgets/cine_pass_button.dart';
import 'package:cinepass_user/widgets/cine_pass_loading.dart';
import 'package:cinepass_user/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signUpController = Get.find<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBoxHeight70,
                  Align(
                    alignment: Alignment.center,
                    child: Text('Create Your\nAccount',
                        style: loginPageTextStyle, textAlign: TextAlign.center),
                  ),
                  sizedBoxHeight70,
                  CinePassTextFormField(
                      hint: 'Enter User Name',
                      prefixIcon: const Icon(Icons.person, size: 25),
                      fieldName: 'Username',
                      controller: nameController),
                  sizedBoxHeight20,
                  CinePassTextFormField(
                      hint: 'Enter Email',
                      prefixIcon: const Icon(Icons.mail_rounded, size: 25),
                      fieldName: 'Email',
                      controller: mailController),
                  sizedBoxHeight20,
                  CinePassTextFormField(
                      hint: 'Enter Mobile Number',
                      prefixIcon: const Icon(Icons.phone, size: 25),
                      fieldName: 'Mobile Number',
                      isDigitsOnly: true,
                      limit: 10,
                      controller: numberController),
                  sizedBoxHeight20,
                  CinePassPasswordTextFormField(
                      hint: 'Enter Password',
                      prefixIcon: const Icon(Icons.lock, size: 25),
                      passwordController: passwordController),
                  sizedBoxHeight20,
                  CinePassTextFormField(
                      hint: 'Enter Confirm Password',
                      prefixIcon: const Icon(Icons.lock, size: 25),
                      fieldName: 'Confirm Password',
                      isLast: true,
                      controller: confirmPasswordController),
                  sizedBoxHeight80,
                  CinePassButton(
                      function: () async {
                        UserModel userModel = UserModel(
                            userName: nameController.text,
                            email: mailController.text,
                            phoneNumber: numberController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text);

                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) => const CinePassLoading());
                          await signUpController.signUpButtonClicked(
                              context, userModel);
                        }
                      },
                      text: 'Sign Up'),
                  sizedBoxHeight70,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.off(LoginScreen());
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: const Text('Sign In'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
