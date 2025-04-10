import 'package:get/get.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;
import 'package:pet_app/domain/responses/login_response.dart';
import 'package:pet_app/domain/responses/profile_response.dart';
import 'package:pet_app/domain/usecases/profile_usecase.dart' as profile_usecase;

class UserProfileController extends GetxController {
  Rx<LoginData?> userData = Rx<LoginData?>(null);
  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);
  RxBool isLoading = false.obs;
  RxBool isEditMode = false.obs;
  RxBool isDataLoaded = false.obs;  // Flag to track if we've tried to load data
   
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString username = ''.obs;
  final RxString email = ''.obs;
   
  final RxBool isFirstNameValid = true.obs;
  final RxBool isLastNameValid = true.obs;
  final RxBool isUsernameValid = true.obs;
  final RxBool isEmailValid = true.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }
  
  Future<void> loadUserData() async {
    isLoading.value = true;
    try { 
      // Make API call to get the profile data
      final response = await profile_usecase.getProfile(180);
      
      // Mark that we've attempted to load data, regardless of success
      isDataLoaded.value = true;
      
      if (response != null && response.data != null) {
        // Successfully loaded profile data from API
        updateFromProfileData(response.data!);
        print("Profile data loaded successfully");
      } else {
        // API call failed or returned no data
        print("No profile data returned from API");
        
        // Clear any existing data to ensure consistent state
        profileData.value = null;
        userData.value = null;
        firstName.value = '';
        lastName.value = '';
        username.value = '';
        email.value = '';
      }
    } catch (e) {
      // Exception during data loading
      print("Error loading profile data: $e");
      isDataLoaded.value = true;  // Still mark as attempted
      profileData.value = null;
      userData.value = null;
    } finally {
      isLoading.value = false;
    }
  }
  
  void updateFromProfileData(ProfileData data) {
    profileData.value = data;
    
    // Also update fields
    firstName.value = data.fname;
    lastName.value = data.lname;
    username.value = data.username;
    email.value = data.email;
  }
  
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }
  
  bool validateInputs() {
    isFirstNameValid.value = firstName.value.trim().isNotEmpty;
    isLastNameValid.value = lastName.value.trim().isNotEmpty;
    isUsernameValid.value = username.value.trim().isNotEmpty;
    isEmailValid.value = email.value.trim().isNotEmpty && GetUtils.isEmail(email.value.trim());
    
    if (!isFirstNameValid.value) {
      Get.snackbar('Validation Error', 'First name is required');
      return false;
    }
    
    if (!isLastNameValid.value) {
      Get.snackbar('Validation Error', 'Last name is required');
      return false;
    }
    
    if (!isUsernameValid.value) {
      Get.snackbar('Validation Error', 'Username is required');
      return false;
    }
    
    if (!isEmailValid.value) {
      Get.snackbar('Validation Error', 'A valid email address is required');
      return false;
    }
    
    return isFirstNameValid.value && isLastNameValid.value && 
           isUsernameValid.value && isEmailValid.value;
  }
  
  Future<bool> updateProfile() async {
    // First, validate all inputs
    if (!validateInputs()) {
      return false;
    }
    
    isLoading.value = true;
    
    try {
      // If we have profile data from the API, use its userId, otherwise use a default value
      final userId = profileData.value != null ? int.tryParse(profileData.value!.userId) ?? 180 : 180;
      
      // Trim all input values to avoid whitespace issues
      final trimmedFirstName = firstName.value.trim();
      final trimmedLastName = lastName.value.trim();
      final trimmedUsername = username.value.trim();
      final trimmedEmail = email.value.trim();
      
      print("Updating profile with fields: firstName='$trimmedFirstName', lastName='$trimmedLastName', username='$trimmedUsername', email='$trimmedEmail'");
      
      // Call the update profile API
      final response = await profile_usecase.updateProfile(
        userId: userId,
        firstName: trimmedFirstName,
        lastName: trimmedLastName,
        username: trimmedUsername,
        email: trimmedEmail,
      );
      
      if (response != null && response.status == 'S') {
        // API update successful, now update local data
        
        // Update profile data if it exists
        if (profileData.value != null) {
          // We can't modify the existing instance directly because ProfileData is immutable
          // so we create a new instance with the updated values
          profileData.value = ProfileData(
            userId: profileData.value!.userId,
            fname: trimmedFirstName,
            lname: trimmedLastName,
            email: trimmedEmail,
            image: profileData.value!.image,
            coverImage: profileData.value!.coverImage,
            token: profileData.value!.token,
            utype: profileData.value!.utype,
            username: trimmedUsername,
            myReferralCode: profileData.value!.myReferralCode,
            isEmailVerified: profileData.value!.isEmailVerified,
            isGovtIdVerified: profileData.value!.isGovtIdVerified
          );
        } else {
          // If profile data doesn't exist yet, create it now with the form values
          profileData.value = ProfileData(
            userId: userId.toString(),
            fname: trimmedFirstName,
            lname: trimmedLastName,
            email: trimmedEmail,
            image: '',
            coverImage: '',
            token: '',
            utype: 'user',
            username: trimmedUsername,
            myReferralCode: '',
            isEmailVerified: '',
            isGovtIdVerified: ''
          );
        }
        
        // Also update login data if it exists
        if (userData.value != null) {
          userData.value = LoginData(
            userId: userData.value!.userId,
            fname: trimmedFirstName,
            lname: trimmedLastName,
            email: trimmedEmail,
            image: userData.value!.image,
            coverImage: userData.value!.coverImage,
            token: userData.value!.token,
            utype: userData.value!.utype,
            username: trimmedUsername,
            myReferralCode: userData.value!.myReferralCode,
            isEmailVerified: userData.value!.isEmailVerified,
            isGovtIdVerified: userData.value!.isGovtIdVerified
          );
        }
        
        isEditMode.value = false;
        return true;
      } else {
        // API update failed
        return false;
      }
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  void logout() {
    HiveManager.writeLoginStatus(false);
    HiveManager.writeUserEmail('');
    HiveManager.writeUserPassword('');
    HiveManager.writeRememberMeStatus(false); 
    Get.offAllNamed('/login');
  }
} 