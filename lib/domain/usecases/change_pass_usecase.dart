import 'package:pet_app/core/utils/functiona.dart';
import 'package:pet_app/data/repositories/change_pass_repository.dart'; 
import 'package:pet_app/domain/repositories/change_pass_repository.dart'; 
import 'package:pet_app/domain/responses/change_pass_response.dart'; 
import 'package:pet_app/presentation/controllers/change_password_controller.dart'; 
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;
import 'package:get/get.dart';
import 'package:pet_app/presentation/pages/login/pages/login.dart';

ChangePasswordRepository _changePasswordRepository = ChangePasswordRepositoryImpl();

Future<bool> changePassword(ChangePasswordController controller) async {
  if (controller.passwordOld.value.isNotEmpty && controller.passwordNew.value.isNotEmpty && controller.passwordConfirm.value.isNotEmpty) {
    try {
      // First verify token validity
      bool hasValidToken = await checkTokenValidity();
      if (!hasValidToken) {
        return false;
      }

      // Call the change password API
      final ChangePasswordResponse response = await _changePasswordRepository.changePassword(
        passwordOld: controller.passwordOld.value,
        passwordNew: controller.passwordNew.value,
      );

      if (response.status == 'S') {
        // Success status - show message and then navigate after a delay
       showCustomSnackbar(
          'Success',
          'Your password has been changed successfully',
          Duration(seconds: 2),
        );
        Future.delayed(Duration(milliseconds: 2300), () {
          Get.back();
        });
        
        return true;
      } else if (response.status == "TE") {
        // Token is invalid or expired
        showCustomSnackbar(
          'Session Expired',
          'Your session has expired. Please log in again.',
          Duration(seconds: 2),
        );
        
        // Clear the token and navigate to login
        await HiveManager.writeUserToken('');
        await HiveManager.writeLoginStatus(false);
        
        // Navigate to login screen
        Future.delayed(Duration(seconds: 2), () {
          Get.offAll(() => LoginScreen());
        });
        
        return false;
      } else {
        // Show error message to user
        showCustomSnackbar(
          'Change Password Failed',
          response.message,
          Duration(seconds: 2),
        );
        return false;
      }
    } catch (e) {
      showCustomSnackbar(
        'Change Password Error',
        'An error occurred during change password: $e',
        Duration(seconds: 2),
      );
      print("Error in changePassword: $e");
      return false;
    }
  } else {
    showCustomSnackbar(
      'Change Password Failed',
      'Please fill in all password fields',
      Duration(seconds: 2),
    ); 
    return false;
  }
}

Future<bool> checkTokenValidity() async {
  String token = await HiveManager.readUserToken();
  bool isLoggedIn = await HiveManager.readLoginStatus();
  
  // Basic validation: check if token exists and user is logged in
  bool isValid = isLoggedIn && token.isNotEmpty;
  
  print("Token validation: isLoggedIn=$isLoggedIn, hasToken=${token.isNotEmpty}");
  
  if (!isValid) {
    showCustomSnackbar(
      'Authentication Required',
      'Please log in to change your password.',
      Duration(seconds: 2),
    );
    
    // Navigate to login screen
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(() => LoginScreen());
    });
  }
  
  return isValid;
}

Future<String> getUserPasswordOld() async {
  String password = await HiveManager.readUserPassword();
  return password;
}

Future<String> getUserPassword() async {
  String password = await HiveManager.readUserPassword();
  return password;
}

Future<String> getUserToken() async {
  String token = await HiveManager.readUserToken();
  print("Retrieved token: $token");
  return token;
}

