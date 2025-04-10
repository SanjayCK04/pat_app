import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/utils/functiona.dart';
import 'package:pet_app/presentation/pages/home/page/home.dart';
import 'package:pet_app/presentation/pages/user_profile/user_profile_screen.dart';

class BottomBarController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
    
    // Navigate based on the index
    switch (index) {
      case 0: // Home
        Get.offAll(() => HomeScreen());
        break;
      case 1: // Bookings
        // Get.to(() => BookingsScreen());
        showCustomSnackbar(
          'Coming Soon',
          'Bookings screen is under development',
          Duration(seconds: 2),
        );
        break;
      case 2: // Search
        // Get.to(() => SearchScreen());
        showCustomSnackbar(
          'Coming Soon',
          'Search screen is under development',
          Duration(seconds: 2),
        );
        break;
      case 3: // Settings/Profile
        Get.to(() => UserProfileScreen());
        break;
    }
  }
}
