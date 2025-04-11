import 'package:get/get.dart';
import 'package:pet_app/core/utils/functiona.dart'; 
import 'package:pet_app/data/repositories/register_repository.dart';
import 'package:pet_app/data/request/register_request.dart'; 
import 'package:pet_app/domain/repositories/register_repository.dart'; 
import 'package:pet_app/domain/responses/register_response.dart'; 
import 'package:pet_app/data/data_sources/local/hive_manager.dart';
import 'package:pet_app/presentation/controllers/register_controller.dart';

RegisterRepository _registerRepository = RegisterRepositoryImpl();

Future<bool> register(RegisterController controller) async {
  if (controller.firstName.value.isNotEmpty && controller.lastName.value.isNotEmpty && controller.userName.value.isNotEmpty && controller.email.value.isNotEmpty && controller.password.value.isNotEmpty) {
    try {
      // Call the login API
      final RegisterResponse response = await _registerRepository.register(
        requestRegister: RegisterRequest(
          fname: controller.firstName.value,
          lname: controller.lastName.value,
          username: controller.userName.value,
          email: controller.email.value,
          password: controller.password.value,
        ),
      );

      if (response.status == 'S') {
        // Success status
        writeLoginStatus(true);
        writeUserEmail(controller.email.value);
        if (controller.isRememberMe.value) {
          writeUserPassword(controller.password.value);
        }
        writeRememberMeStatus(controller.isRememberMe.value);
        return true;
      } else {
        // Show error message to user
        showCustomSnackbar(
          'Registration Failed',
          response.message,
          Duration(seconds: 2),
        );
        return false;
      }
    } catch (e) {
      showCustomSnackbar(
        'Registration Error',
        'An error occurred during registration.',
        Duration(seconds: 2),
      );
      return false;
    }
  } else {
    showCustomSnackbar(
      'Registration Failed',
      'Please fill in all required fields: First Name, Last Name, Username, Email, and Password',
      Duration(seconds: 2),
    );
    return false;
  }
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

Future<String> getUserPasswordOld() async {
  String password = await readUserPassword();
  return password;
}
