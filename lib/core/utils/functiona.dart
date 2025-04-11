import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMM yyyy'); // Example: 29 Nov 2024
  return formatter.format(date);
}
String formatTime(DateTime date) {
  final DateFormat timeFormatter = DateFormat('hh:mm a'); // Example: 10:58 AM
  return timeFormatter.format(date);
}


SnackbarController showCustomSnackbar(String title, String message, Duration duration) {

  // Check if a snackbar is already showing and close it safely
  try {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
  } catch (e) {
    print("Error closing existing snackbars: $e");
  }
  
  // Show new snackbar with configuration to avoid conflicts
  return Get.snackbar(
    title, 
    message,
    colorText: Colors.white,
    backgroundColor: const Color.fromARGB(131, 78, 78, 78),
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: duration.inSeconds),
    isDismissible: true,
    overlayBlur: 0,
  );
}


  // return Get.snackbar(
  //   title, 
  //   message,
  //   colorText: Colors.white,
  //   backgroundColor: const Color.fromARGB(134, 0, 0, 0),
  //   snackPosition: SnackPosition.TOP,
  //   duration: Duration(seconds: duration.inSeconds),
  //   isDismissible: true,
  //   overlayBlur: 0,
  // );