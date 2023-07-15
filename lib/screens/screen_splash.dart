import 'package:cinepass_user/view_models/splash_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashScreenController = Get.put(SplashScreenViewModel());

  @override
  Widget build(BuildContext context) {
    splashScreenController.navigateTo();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GifView.asset(
              'animations/splash_screen_animation.gif',
              loop: false,
              height: Adaptive.h(25),
              width: Adaptive.w(65),
            ),
          )
        ],
      ),
    );
  }
}
