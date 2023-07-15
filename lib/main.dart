import 'package:cinepass_user/screens/screen_splash.dart';
import 'package:cinepass_user/utils/colors.dart';
import 'package:cinepass_user/view_models/signup_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  Get.put(SignUpViewModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cine Pass',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                primary: primaryColor,
                background: backgroundColor),
            useMaterial3: true,
            fontFamily: 'Poppins'),
        home: SplashScreen(),
      );
    });
  }
}
