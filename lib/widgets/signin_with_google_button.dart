import 'package:cinepass_user/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adaptive.w(100),
      height: Adaptive.h(6.7),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13))),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/google_logo.png',
                width: Adaptive.w(7),
                height: Adaptive.h(7),
              ),
              SizedBox(
                width: Adaptive.w(5),
              ),
              Text(
                'Sign in with Google',
                style: TextStyle(
                    color: hintColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
