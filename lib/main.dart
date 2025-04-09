import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/utils/utility_functions.dart';
import 'package:pet_app/presentation/pages/home/page/home.dart';
import 'package:pet_app/presentation/pages/login/pages/login.dart';
import 'package:pet_app/presentation/pages/splash/splash.dart';

void main() async {
  initHive().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRememberMe = false;
  bool isLoggedIn = false;
  Widget home = const SplashScreenNoButtons();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    initControllerInjections().then((value) {
      isLoggedIn = loginController.isLoggedIn.value;
      isRememberMe = loginController.isRememberMe.value;
      isLoggedIn
          ? isRememberMe
              ? home = HomeScreen()
              : home = LoginScreen()
          : home = const SplashScreen();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    heightRatio = screenHeight / refHeight;
    widthRatio = screenWidth / refWidth;
    return SafeArea(
      bottom: false,
      child: GetMaterialApp(
        defaultTransition: Transition.fadeIn,
        debugShowCheckedModeBanner: false,
        title: 'Pet App',
        home: home,
      ),
    );
  }
}
