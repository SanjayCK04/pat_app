import 'package:get/get.dart';
import 'package:pet_app/core/utils/functiona.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;
import 'package:pet_app/domain/usecases/change_pass_usecase.dart' as change_pass_usecase;
import 'package:pet_app/domain/usecases/register_usecase.dart' as register_usecase;

class ChangePasswordController extends GetxController {
  // Observable variables for password fields
  RxString passwordOld = ''.obs;
  RxString passwordNew = ''.obs;
  RxString passwordConfirm = ''.obs;
  
  // Loading state
  RxBool isLoading = false.obs;
  
  // Constructor to pre-fill old password if available
  ChangePasswordController() {
    register_usecase.getUserPassword().then((value) {
      // Only pre-fill if it's saved due to remember me
      if (value.isNotEmpty) {
        HiveManager.readRememberMeStatus().then((isRemembered) {
          if (isRemembered) {
            passwordOld.value = value;
          }
        });
      }
    });
  }
  
  // Set password values
  void setOldPassword(String value) {
    passwordOld.value = value;
  }
  
  void setNewPassword(String value) {
    passwordNew.value = value;
  }
  
  void setConfirmPassword(String value) {
    passwordConfirm.value = value;
  }
  
  // Clear all password fields
  void clearPasswords() {
    passwordOld.value = '';
    passwordNew.value = '';
    passwordConfirm.value = '';
  }
  
  // Validate password input
  bool validateInput() {
    if (passwordOld.value.isEmpty) {
      showCustomSnackbar('Error', 'Please enter your current password', Duration(seconds: 2));
      return false;
    }
    
    if (passwordNew.value.isEmpty) {
      showCustomSnackbar('Error', 'Please enter a new password', Duration(seconds: 2));
      return false;
    }
    
    if (passwordNew.value.length < 6) {
      showCustomSnackbar('Error', 'New password must be at least 6 characters', Duration(seconds: 2));
      return false;
    }
    
    if (passwordConfirm.value != passwordNew.value) {
      showCustomSnackbar('Error', 'Passwords do not match', Duration(seconds: 2));
      return false;
    }
    
    return true;
  }
  
  // Change password API call
  Future<bool> changePassword() async {
    if (!validateInput()) {
      return false;
    }
    
    isLoading.value = true;
    
    try {
      // Call the change password use case
      final result = await change_pass_usecase.changePassword(this);
      
      if (result) {
        // Password changed successfully
        // No need to show a success message here as it's shown in the usecase
        
        // Update saved password if remember me is enabled
        HiveManager.readRememberMeStatus().then((isRemembered) {
          if (isRemembered) {
            HiveManager.writeUserPassword(passwordNew.value);
          }
        });
        
        // Clear the form
        clearPasswords();
        
        // Navigation is handled in the usecase
      }
      
      return result;
    } catch (e) {
      showCustomSnackbar('Error', 'An error occurred: ${e.toString()}', Duration(seconds: 2));
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
   
