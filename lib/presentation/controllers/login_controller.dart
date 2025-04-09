import 'package:get/get.dart';
import 'package:pet_app/domain/usecases/login_usecase.dart' as login_usecase;

class LoginController extends GetxController {
  RxBool isRememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  LoginController() {
    login_usecase.checkLoginStatus().then((value) {
      isLoggedIn.value = value;
    });
    login_usecase.checkRememberMeStatus().then((value) {
      isRememberMe.value = value;
    });
    login_usecase.getUserEmail().then((value) {
      email.value = value;
    });
    login_usecase.getUserPassword().then((value) {
      password.value = value;
    });
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  bool login() {
    isLoggedIn = login_usecase.login(this).obs;
    return isLoggedIn.value;
  }
}
