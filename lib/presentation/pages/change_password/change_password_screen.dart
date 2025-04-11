import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/utils/functiona.dart';
import 'package:pet_app/core/utils/utility_functions.dart';
import 'package:pet_app/core/widgets/common_widgets.dart';
import 'package:pet_app/presentation/controllers/change_password_controller.dart'; 

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  RxBool isOldPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  
  @override
  void initState() {
    super.initState();
    
    // Set up listeners to update controller values when text changes
    oldPasswordController.addListener(() {
      changePasswordController.setOldPassword(oldPasswordController.text);
    });
    
    newPasswordController.addListener(() {
      changePasswordController.setNewPassword(newPasswordController.text);
    });
    
    confirmPasswordController.addListener(() {
      changePasswordController.setConfirmPassword(confirmPasswordController.text);
    });
  }
  
  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(20),
                  vertical: getHeight(20),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: getHeight(30),
                      height: getHeight(30),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        color: Colors.black,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withAlpha((0.8 * 255).toInt()),
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                        ),
                        alignment: Alignment.center,
                        icon: Padding(
                          padding: EdgeInsets.only(right: getWidth(2)),
                          child: Image.asset(
                            getImagePath('back_button'),
                            width: getHeight(10),
                            fit: BoxFit.fitWidth,
                            isAntiAlias: true,
                          ),
                        ),
                      ),
                    ),
                    widthDivider(19),
                    makeText(
                      'Change Password',
                      context,
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightDivider(20),
                        
                        // Description
                        makeText(
                          'Create a new password for your account',
                          context,
                          size: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        
                        heightDivider(30),
                        
                        // Old password input - sync with Obx values from controller
                        Obx(() {
                          // Initialize text controller with value from RxString if needed
                          if (changePasswordController.passwordOld.value.isNotEmpty && 
                              oldPasswordController.text.isEmpty) {
                            oldPasswordController.text = changePasswordController.passwordOld.value;
                          }
                          
                          return makeInputBox(
                            'Current Password',
                            oldPasswordController,
                            context,
                            isPassword: true,
                            shouldObscureText: !isOldPasswordVisible.value,
                            isError: oldPasswordController.text.isEmpty && changePasswordController.isLoading.value == false,
                            errorText: 'Please enter your current password',
                            visibilityButton: IconButton(
                              icon: Icon(
                                isOldPasswordVisible.value 
                                  ? Icons.visibility_off 
                                  : Icons.visibility,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              onPressed: () => isOldPasswordVisible.value = !isOldPasswordVisible.value,
                            ),
                          );
                        }),
                        
                        heightDivider(20),
                        
                        // New password input
                        Obx(() => makeInputBox(
                          'New Password',
                          newPasswordController,
                          context,
                          isPassword: true,
                          shouldObscureText: !isNewPasswordVisible.value,
                          isError: newPasswordController.text.length < 6 && newPasswordController.text.isNotEmpty && 
                                   changePasswordController.isLoading.value == false,
                          errorText: 'New password must be at least 6 characters',
                          visibilityButton: IconButton(
                            icon: Icon(
                              isNewPasswordVisible.value 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () => isNewPasswordVisible.value = !isNewPasswordVisible.value,
                          ),
                        )),
                        
                        heightDivider(20),
                        
                        // Confirm password input
                        Obx(() => makeInputBox(
                          'Confirm New Password',
                          confirmPasswordController,
                          context,
                          isPassword: true,
                          shouldObscureText: !isConfirmPasswordVisible.value,
                          isError: confirmPasswordController.text.isNotEmpty && 
                                   confirmPasswordController.text != newPasswordController.text && 
                                   changePasswordController.isLoading.value == false,
                          errorText: 'Passwords do not match',
                          visibilityButton: IconButton(
                            icon: Icon(
                              isConfirmPasswordVisible.value 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            onPressed: () => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value,
                          ),
                        )),
                        
                        heightDivider(40),
                        
                        // Change Password button
                        Obx(() => changePasswordController.isLoading.value
                          ? Center(
                              child: Container(
                                width: double.infinity,
                                height: getHeight(55),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(getWidth(10)),
                                  gradient: orangeGradient,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            )
                          : makeFilledButton(
                              makeText(
                                'Change Password',
                                context,
                                size: 18,
                                weight: FontWeight.w500,
                              ),
                              () async {
                                FocusScope.of(context).unfocus(); // Hide keyboard
                                
                                // Update controller values one last time
                                changePasswordController.setOldPassword(oldPasswordController.text);
                                changePasswordController.setNewPassword(newPasswordController.text);
                                changePasswordController.setConfirmPassword(confirmPasswordController.text);
                                
                                final result = await changePasswordController.changePassword();
                                if (result) {
                                  // Clear the input fields on success immediately
                                  oldPasswordController.clear();
                                  newPasswordController.clear();
                                  confirmPasswordController.clear();
                                  
                                  // Navigation is handled in the usecase
                                }
                              },
                              context,
                              gradient: orangeGradient,
                              margin: EdgeInsets.zero,
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 