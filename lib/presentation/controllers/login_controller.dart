import 'package:get/get.dart'; 
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;
import 'package:pet_app/domain/usecases/login_usecase.dart' as login_usecase;
import 'package:pet_app/presentation/pages/login/pages/login.dart';

class LoginController extends GetxController {
  RxBool isRememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isLoading = false.obs;

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

  Future<bool> login() async {
    isLoading.value = true;
    
    try {
      final result = await login_usecase.login(this);
      isLoggedIn.value = result;
      return result;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    HiveManager.writeLoginStatus(false);
    HiveManager.writeUserEmail('');
    HiveManager.writeUserPassword('');
    HiveManager.writeRememberMeStatus(false);
    Get.offAll(() => LoginScreen()); // Navigate to login screen and remove all previous screens
  }
}
