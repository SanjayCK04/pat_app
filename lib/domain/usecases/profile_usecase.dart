import 'package:get/get.dart';
import 'package:pet_app/core/utils/functiona.dart';
import 'package:pet_app/data/repositories/profile_repository.dart';
import 'package:pet_app/domain/repositories/profile_repository.dart';
import 'package:pet_app/domain/responses/profile_response.dart';
import 'package:pet_app/domain/responses/update_profile_response.dart';
import 'package:pet_app/presentation/controllers/user_profile_controller.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;
import 'package:pet_app/presentation/pages/login/pages/login.dart'; 
ProfileRepository _profileRepository = ProfileRepositoryImpl();

Future<ProfileResponse?> getProfile(int userId) async {
  try {
    // Call the profile API
    final ProfileResponse response = await _profileRepository.getProfile(
      userId: userId,
    );

    if (response.status == 'S') {
      // Success status
      if (response.data == null) {
        // API returned success but with no data
        print("API returned success but with null data");
        showCustomSnackbar(
          'Profile Info',
          'Profile data is not available',
          Duration(seconds: 2),
        );
      }
      return response;
    } else {
      // Show error message to user
      showCustomSnackbar(
        'Profile Fetch Failed',
        response.message,
        Duration(seconds: 2),
      );
      return null;
    }
  } catch (e) {
    showCustomSnackbar(
      'Profile Error',
      'An error occurred while fetching profile.',
      Duration(seconds: 2),
    ); 
    print("Exception in getProfile: $e");
    return null;
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
      'Please log in to update your profile.',
      Duration(seconds: 2),
    );
    
    // Navigate to login screen
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(() => LoginScreen());
    });
  }
  
  return isValid;
}

Future<UpdateProfileResponse?> updateProfile({
  required int userId,
  required String firstName,
  required String lastName,
  required String username,
  required String email,
}) async {
  // Validate input fields first
  if (firstName.isEmpty || lastName.isEmpty || username.isEmpty || email.isEmpty) {
    showCustomSnackbar(
      'Invalid Input',
      'All fields are required. Please make sure you fill in all the fields.',
      Duration(seconds: 2),
    );
    return null;
  }

  // First check if the user has a valid token
  bool hasValidToken = await checkTokenValidity();
  if (!hasValidToken) {
    return null;
  }
  
  try {
    print("Calling updateProfile API with fields - firstName: '$firstName', lastName: '$lastName', username: '$username', email: '$email'");
    
    // Call the update profile API
    final UpdateProfileResponse response = await _profileRepository.updateProfile(
      userId: userId,
      fname: firstName,
      lname: lastName,
      username: username,
      email: email,
    );

    if (response.status == 'S') {
      // Success status
      showCustomSnackbar(
        'Success',
        'Your profile has been updated successfully',
        Duration(seconds: 2),
      );
      return response;
    } else if (response.message.contains('Unauthorized Token')) {
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
      
      return null;
    } else {
      // Other error
      String errorMessage = response.message;
      
      // Check for specific field errors and provide clearer feedback
      if (errorMessage.contains('firstname') || errorMessage.contains('lastname') || 
          errorMessage.contains('username') || errorMessage.contains('email')) {
        errorMessage = 'Please make sure all fields are filled in correctly: $errorMessage';
      }
      
      showCustomSnackbar(
        'Profile Update Failed',
        errorMessage,
        Duration(seconds: 2),
      );
      return null;
    }
  } catch (e) {
    showCustomSnackbar(
      'Profile Update Error',
      'An error occurred while updating profile: $e',
      Duration(seconds: 2),
    );
    return null;
  }
}

// Update the UserProfileController to use real data from API
Future<void> updateUserProfileFromAPI(UserProfileController controller, int userId) async {
  controller.isLoading.value = true;
  
  try {
    final response = await getProfile(userId);
    
    if (response != null && response.data != null) {
      // Use the new method to update from ProfileData
      controller.updateFromProfileData(response.data!);
    }
  } finally {
    controller.isLoading.value = false;
  }
} 