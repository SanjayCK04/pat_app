import 'package:pet_app/core/utils/functiona.dart';
import 'package:pet_app/data/repositories/login_repository.dart';
import 'package:pet_app/domain/repositories/login_repository.dart';
import 'package:pet_app/domain/responses/login_response.dart';
import 'package:pet_app/presentation/controllers/login_controller.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart';

LoginRepository _loginRepository = LoginRepositoryImpl();

Future<bool> login(LoginController controller) async {
  if (controller.email.value.isNotEmpty &&
      controller.password.value.isNotEmpty) {
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

          // Save user ID
          int userId = response.data!.userId;
          print("Saving user ID: $userId");
          writeUserId(userId);
        }

        return true;
      } else {
        // Show error message to user
        showCustomSnackbar(
          'Login Failed',
          response.message,
          Duration(seconds: 2),
        );
        return false;
      }
    } catch (e) {
      showCustomSnackbar(
        'Login Error',
        'An error occurred during login.',
        Duration(seconds: 2),
      );
      return false;
    }
  } else {
    showCustomSnackbar(
      'Login Failed',
      'Please enter email and password',
      Duration(seconds: 2),
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
