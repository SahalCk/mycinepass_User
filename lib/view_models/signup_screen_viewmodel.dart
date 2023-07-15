import 'dart:convert';
import 'dart:developer';
import 'package:cinepass_user/models/user_model.dart';
import 'package:cinepass_user/screens/screen_home.dart';
import 'package:cinepass_user/screens/screen_otp.dart';
import 'package:cinepass_user/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel extends GetxController {
  late UserModel userModel;

  Future<void> signUpButtonClicked(
      BuildContext context, UserModel localUserModel) async {
    if (mailvalidation(localUserModel.email)) {
      Navigator.of(context).pop();
      snackBar(context, 'Invalid Email');
    } else if (localUserModel.phoneNumber.length < 10) {
      Navigator.of(context).pop();
      snackBar(context, 'Invalid Mobile Number');
    } else if (localUserModel.password != localUserModel.confirmPassword) {
      Navigator.of(context).pop();
      snackBar(context, 'Password mismatches with Confirm Password');
    } else {
      userModel = localUserModel;
      http.Response response;
      try {
        response = await APIServices().validateSignUpGetOtp(userModel);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          Get.back();
          Get.to(OTPScreen());
        } else {
          Get.back();
          snackBar(context, 'Something went wrong !');
        }
      } catch (e) {
        snackBar(context, e.toString());
      }
    }
  }

  Future<void> otpSubmitButtonClicked(
      BuildContext context, String enteredOtp) async {
    http.Response response;
    try {
      response = await APIServices().otpSubmitAPI(enteredOtp, userModel);
      final status = jsonDecode(response.body) as Map<String, dynamic>;

      if (status['status'] == true) {
        Get.back();
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setBool('isAlreadyLoggedIn', true);
        Get.offAll(const HomeScreen());
      } else {
        Get.back();
        snackBar(context, 'Incorrect OTP');
      }
    } catch (e) {
      snackBar(context, e.toString());
    }
  }

  Future<void> resendOTP(BuildContext context, String email) async {
    final http.Response response;
    try {
      response = await APIServices().resendOTP(email);
      final status = jsonDecode(response.body) as Map<String, dynamic>;

      if (status['status'] == true) {
        snackBarResendOTP(context, email);
      } else {
        snackBar(context, 'Something went wrong!');
      }
    } catch (e) {
      snackBar(context, e.toString());
    }
  }

  bool mailvalidation(String email) {
    if (!email.contains('@') || !email.contains('.')) {
      return true;
    } else {
      final splitted = email.split('@');
      if (splitted[0].isEmpty) {
        return true;
      } else if (splitted[1].isEmpty) {
        return true;
      }
    }
    return false;
  }

  void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
        content: Text(message)));
  }

  void snackBarResendOTP(BuildContext context, String mail) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
        content: Text('New OTP has sent to $mail')));
  }
}
