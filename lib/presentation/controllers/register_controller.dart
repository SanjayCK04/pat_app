import 'package:get/get.dart';  
import 'package:pet_app/domain/usecases/register_usecase.dart' as register_usecase; 

class RegisterController extends GetxController {
  RxBool isRememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool isLoading = false.obs;

  RegisterController() {
    register_usecase.checkLoginStatus().then((value) {
      isLoggedIn.value = value;
    });
    register_usecase.checkRememberMeStatus().then((value) {
      isRememberMe.value = value;
    });
    register_usecase.getUserEmail().then((value) {
      email.value = value;
    });
    register_usecase.getUserPassword().then((value) {
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

  void setFirstName(String value) {
    firstName.value = value;
  }

  void setLastName(String value) {
    lastName.value = value;
  }

  void setUserName(String value) {
    userName.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Future<bool> register() async {
    isLoading.value = true;
    
    try {
      final result = await register_usecase.register(this);
      isLoggedIn.value = result;
      return result;
    } finally {
      isLoading.value = false;
    }
  }
}
   
