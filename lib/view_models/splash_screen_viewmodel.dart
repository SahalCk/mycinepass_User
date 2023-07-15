import 'package:cinepass_user/screens/screen_home.dart';
import 'package:cinepass_user/screens/screen_signin.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel extends GetxController {
  Future<void> navigateTo() async {
    await Future.delayed(const Duration(seconds: 3));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (sharedPreferences.getBool('isAlreadyLoggedIn') == null) {
      await sharedPreferences.setBool('isAlreadyLoggedIn', false);
    }
    if (sharedPreferences.getBool('isAlreadyLoggedIn')!) {
      Get.off(const HomeScreen());
    } else {
      Get.off(LoginScreen());
    }
  }
}
