import 'package:pet_app/presentation/controllers/login_controller.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart';

bool login(LoginController controller) {
  if (controller.email.value.isNotEmpty &&
      controller.password.value.isNotEmpty) {
    writeLoginStatus(true);
    writeUserEmail(controller.email.value);
    writeUserPassword(controller.password.value);
    writeRememberMeStatus(controller.isRememberMe.value);
    return true;
  } else {
    return false;
  }
}

bool logout() {
  writeLoginStatus(false);
  writeRememberMeStatus(false);
  writeUserEmail('');
  writeUserPassword('');
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
