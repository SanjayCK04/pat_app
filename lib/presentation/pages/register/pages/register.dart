import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/utils/utility_functions.dart';
import 'package:pet_app/core/widgets/common_widgets.dart'; 
import 'package:pet_app/presentation/pages/login/pages/login.dart';
import 'package:pet_app/presentation/pages/login/widgets/login_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();


    emailController.text = registerController.email.value;
    passwordController.text = registerController.password.value;
    firstNameController.text = registerController.firstName.value;
    lastNameController.text = registerController.lastName.value;
    userNameController.text = registerController.userName.value;


    emailController.addListener(() {
      registerController.setEmail(emailController.text);
    });

    passwordController.addListener(() {
      registerController.setPassword(passwordController.text);
    });

    firstNameController.addListener(() {
      registerController.setFirstName(firstNameController.text);
    });

    lastNameController.addListener(() {
      registerController.setLastName(lastNameController.text);
    });

    userNameController.addListener(() {
      registerController.setUserName(userNameController.text);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        // height: getHeight(screenHeight),
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: getWidth(10)),
                  child: Column(
                    children: [
                      Image.asset(getImagePath('logo'), height: getHeight(110)),
                      heightDivider(30),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: getWidth(10)),
                        child: makeText(
                          'Sign Up',
                          context,
                          size: 24,
                          align: TextAlign.left,
                          weight: FontWeight.w500,
                        ),
                      ),
                      heightDivider(30),
                      makeInputBox(
                        'Enter your first name',
                        firstNameController,
                        context,
                        hint: 'First Name',
                        inputType: TextInputType.text,
                      ),
                      heightDivider(30),
                      makeInputBox(
                        'Enter your last name',
                        lastNameController,
                        context,
                        hint: 'Last Name',
                        inputType: TextInputType.text,
                      ),
                      heightDivider(30),
                      makeInputBox(
                        'Enter your username',
                        userNameController,
                        context,
                        hint: 'Username',
                        inputType: TextInputType.text,
                      ),
                      heightDivider(30),
                      makeInputBox(
                        'Enter your email address',
                        emailController,
                        context,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                      ),
                      heightDivider(20),
                      Obx(
                        () => makeInputBox(
                          'Password',
                          passwordController,
                          context,
                          inputType: TextInputType.visiblePassword,
                          hint: 'Password',
                          isPassword: true,
                          shouldObscureText:
                              !loginController.isPasswordVisible.value,
                          visibilityButton:
                              loginController.password.value.isNotEmpty
                                  ? Obx(
                                    () => IconButton(
                                      alignment: Alignment.center,

                                      padding: EdgeInsets.zero,
                                      style: IconButton.styleFrom(
                                        alignment: Alignment.center,
                                        shape: CircleBorder(),
                                        iconSize: getWidth(20),
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      onPressed: () {
                                        loginController
                                            .togglePasswordVisibility();
                                      },
                                      icon: Icon(
                                        loginController.isPasswordVisible.value
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        color: Colors.white.withAlpha(
                                          (0.5 * 255).floor(),
                                        ),
                                        applyTextScaling: false,
                                        size: getWidth(20),
                                      ),
                                    ),
                                  )
                                  : null,
                        ),
                      ),
                      heightDivider(50),
                      registerController.isLoading.value ? Center(child: CircularProgressIndicator()) : makeFilledButton(
                        makeText(
                          'Sign Up',
                          context,
                          size: 23,
                          weight: FontWeight.w500,
                          fontFamily: roboto,
                        ),
                        () async { 
                          print("what is bool--${registerController.isLoading.value}");
                          var res = await registerController.register();
                          res
                              ? Get.to(
                                LoginScreen(),
                                transition: Transition.cupertinoDialog,
                                duration: const Duration(milliseconds: 500),
                              )
                              : null; 
                        },
                        context,
                        margin: EdgeInsets.zero,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => IconButton.filled(
                                  onPressed: () {
                                    registerController.toggleRememberMe();
                                  },
                                  padding: EdgeInsets.zero,
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: CircleBorder(),
                                  ),
                                  color:
                                      registerController.isRememberMe.value
                                          ? Colors.white
                                          : Colors.transparent,
                                  icon: Icon(
                                    registerController.isRememberMe.value
                                        ? Icons.check_box_rounded
                                        : Icons.check_box_outline_blank_rounded,
                                    color: Colors.white,
                                    size: getWidth(16),
                                    applyTextScaling: false,
                                  ),
                                ),
                              ),
                              makeText(
                                'Remember Me',
                                context,
                                size: 14,
                                weight: FontWeight.w300,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: makeText(
                              'Need help?',
                              context,
                              size: 14,
                              weight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                heightDivider(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginOptionButton(
                      'Google',
                      context,
                      getImagePath('google'),
                    ),
                    widthDivider(20),
                    loginOptionButton('Apple', context, getImagePath('apple')),
                  ],
                ),
                heightDivider(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      getImagePath('line_left'),
                      width: getWidth(140),
                    ),
                    widthDivider(20),
                    makeText('OR', context, size: 20),
                    widthDivider(20),
                    Image.asset(
                      getImagePath('line_right'),
                      width: getWidth(140),
                    ),
                  ],
                ),
                heightDivider(min(45, screenHeight * 0.01)),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getHeight(10),
                    horizontal: getWidth(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeText(
                        'Don\'t have an account?',
                        context,
                        size: 20,
                        weight: FontWeight.w300,
                      ),
                      widthDivider(5),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {},
                        child: makeText(
                          'Sign Up',
                          context,
                          size: 20,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
