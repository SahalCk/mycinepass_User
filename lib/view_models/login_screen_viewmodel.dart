import 'dart:convert';
import 'package:cinepass_user/screens/screen_home.dart';
import 'package:cinepass_user/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends GetxController {
  RxBool obscureValue = true.obs;

  void changeObscure() {
    if (obscureValue.value == true) {
      obscureValue.value = false;
    } else {
      obscureValue.value = true;
    }
  }

  Future<void> signinButtonClicked(
      BuildContext context, String email, String password) async {
    final http.Response response;
    response = await APIServices().signInAPI(email, password);
    final status = jsonDecode(response.body) as Map<String, dynamic>;

    try {
      if (status.containsKey("noUser")) {
        Get.back();
        snackBar(context, "User doesn't exist! Please create an account");
      } else if (status.containsKey("incPass")) {
        Get.back();
        snackBar(context, "Incorrect Password");
      } else if (status.containsKey("token")) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: status['token']);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setBool('isAlreadyLoggedIn', true);
        Get.offAll(const HomeScreen());
      }
    } catch (e) {
      snackBar(context, e.toString());
    }
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
}
