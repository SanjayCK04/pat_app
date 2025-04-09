import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/widgets/common_widgets.dart';
import 'package:pet_app/presentation/pages/login/pages/login.dart';
import 'package:pet_app/presentation/pages/register/pages/register.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashBackgroundImage),
            fit: BoxFit.cover,
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            makeText(
              'Lorem Ipsum is simply dummy text of\nprinting and type setting industry.\nIpsum has been the industry',
              context,
              align: TextAlign.center,
              letterSpacing: 0,
              weight: FontWeight.w300,
            ),
            heightDivider(50),
            makeFilledButton(
              makeText(
                'Sign In',
                context,
                size: 23,
                weight: FontWeight.w500,
                fontFamily: roboto,
              ),
              () {
                Get.to(
                  LoginScreen(),
                  transition: Transition.cupertinoDialog,
                  duration: const Duration(milliseconds: 500),
                );
              },
              context,
            ),
            heightDivider(30),
            makeOutinedButton(
              makeText('Sign Up', context, size: 23),
              () {
                Get.to(
                  RegisterScreen(),
                  transition: Transition.cupertinoDialog,
                  duration: const Duration(milliseconds: 500),
                );
              },
              context,
            ),
            heightDivider(50),
          ],
        ),
      ),
    );
  }
}

class SplashScreenNoButtons extends StatelessWidget {
  const SplashScreenNoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashBackgroundImage),
            fit: BoxFit.cover,
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Container(),
      ),
    );
  }
}
