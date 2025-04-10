part of 'user_profile_widgets.dart';

class EditProfileForm extends GetView<UserProfileController> {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create TextEditingControllers with initial values
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    
    firstNameController.text = controller.firstName.value;
    lastNameController.text = controller.lastName.value;
    usernameController.text = controller.username.value;
    emailController.text = controller.email.value;
    
    firstNameController.addListener(() {
      controller.firstName.value = firstNameController.text;
      // Reset validation state when text changes
      controller.isFirstNameValid.value = true;
    });
    
    lastNameController.addListener(() {
      controller.lastName.value = lastNameController.text;
      // Reset validation state when text changes
      controller.isLastNameValid.value = true;
    });
    
    usernameController.addListener(() {
      controller.username.value = usernameController.text;
      // Reset validation state when text changes
      controller.isUsernameValid.value = true;
    });
    
    emailController.addListener(() {
      controller.email.value = emailController.text;
      // Reset validation state when text changes
      controller.isEmailValid.value = true;
    });
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightDivider(20),
          makeText(
            'Edit Profile',
            context,
            size: 18,
            weight: FontWeight.w500,
          ),
          heightDivider(15),
          Obx(() => makeInputBox(
            'First Name',
            firstNameController,
            context,
            isError: !controller.isFirstNameValid.value,
            errorText: 'First name is required',
          )),
          heightDivider(15),
          Obx(() => makeInputBox(
            'Last Name',
            lastNameController,
            context,
            isError: !controller.isLastNameValid.value,
            errorText: 'Last name is required',
          )),
          heightDivider(15),
          Obx(() => makeInputBox(
            'Username',
            usernameController,
            context,
            isError: !controller.isUsernameValid.value,
            errorText: 'Username is required',
          )),
          heightDivider(15),
          Obx(() => makeInputBox(
            'Email',
            emailController,
            context,
            inputType: TextInputType.emailAddress,
            isError: !controller.isEmailValid.value,
            errorText: 'A valid email address is required',
          )),
          heightDivider(25),
          
          // Save button
          Obx(() => 
            controller.isLoading.value 
              ? Center(child: CircularProgressIndicator(color: Colors.white)) 
              : makeFilledButton(
                  makeText(
                    'Save Changes',
                    context,
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                  () async {
                    final result = await controller.updateProfile();
                    if (result) {
                      Get.snackbar(
                        'Success',
                        'Profile updated successfully',
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      // Error message is shown by the controller or usecase
                    }
                  },
                  context,
                  margin: EdgeInsets.zero,
                ),
          ),
          heightDivider(90),
        ],
      ),
    );
  }
} 