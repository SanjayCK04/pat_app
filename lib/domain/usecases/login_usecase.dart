import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/data/repositories/login_repository.dart';
import 'package:pet_app/domain/repositories/login_repository.dart';
import 'package:pet_app/domain/responses/login_response.dart';
import 'package:pet_app/presentation/controllers/login_controller.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart';

LoginRepository _loginRepository = LoginRepositoryImpl();

Future<bool> login(LoginController controller) async {
  if (controller.email.value.isNotEmpty && controller.password.value.isNotEmpty) {
    try {
      // Call the login API
      final LoginResponse response = await _loginRepository.login(
        email: controller.email.value,
        password: controller.password.value,
      );

      if (response.status == 'S') {
        // Success status
        writeLoginStatus(true);
        writeUserEmail(controller.email.value);
        if (controller.isRememberMe.value) {
          writeUserPassword(controller.password.value);
        }
        writeRememberMeStatus(controller.isRememberMe.value);
        
        // Save token from response
        if (response.data != null) {
          String token = response.data!.token;
          print("Saving token: $token");
          writeUserToken(token);
          controller.token.value = token;
        }
        
        return true;
      } else {
        // Show error message to user
        Get.snackbar(
          'Login Failed',
          response.message,
          colorText: Colors.white,
          animationDuration: Duration(milliseconds: 200),
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Login Error',
        'An error occurred during login.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  } else {
    Get.snackbar(
      'Login Failed',
      'Please enter email and password',
      snackPosition: SnackPosition.BOTTOM,
    );
    return false;
  }
}

bool logout() {
  writeLoginStatus(false);
  writeRememberMeStatus(false);
  writeUserEmail('');
  writeUserPassword('');
  writeUserToken(''); // Clear the token on logout
  return true;
}

Future<bool> checkLoginStatus() async {
  bool isLoggedIn = await readLoginStatus();
  return isLoggedIn;
}

Future<bool> checkRememberMeStatus() async {
  bool isRememberMe = await readRememberMeStatus();
  return isRememberMe;
}

Future<String> getUserEmail() async {
  String email = await readUserEmail();
  return email;
}

Future<String> getUserPassword() async {
  String password = await readUserPassword();
  return password;
}

Future<String> getUserToken() async {
  String token = await readUserToken();
  print("Retrieved token: $token");
  return token;
}

