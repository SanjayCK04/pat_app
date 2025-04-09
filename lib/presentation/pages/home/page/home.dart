import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/utils/utility_functions.dart';
import 'package:pet_app/core/widgets/common_widgets.dart';
import 'package:pet_app/presentation/controllers/dogs_controller.dart';
import 'package:pet_app/presentation/pages/home/widgets/home_widgets.dart';
import 'package:pet_app/presentation/pages/profile/page/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(gradient: backgroundGradient),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  heightDivider(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widthDivider(20),
                          makeText(
                            'Home',
                            context,
                            size: 24,
                            weight: FontWeight.w500,
                            letterSpacing: getWidth(1),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SwitchDogHuman(),
                          widthDivider(20),
                          NotificationIcon(),
                          widthDivider(20),
                        ],
                      ),
                    ],
                  ),
                  heightDivider(30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Obx(
                              () => getHomeScreenIconButtonWithLabel(
                                getImagePath(
                                  'profile_${homePageController.isDog.value ? 'dog' : 'human'}',
                                ),
                                'My Profile',
                                context,
                                isProfile: true,
                                onTap: () {
                                  Get.find<DogsController>(
                                    tag: 'currentDog',
                                  ).changeDog(dogsList[0].obs);
                                  homePageController.isDog.value
                                      ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(),
                                        ),
                                      )
                                      : null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: getHeight(20),
                              ),
                              child: getHomeScreenIconButtonWithLabel(
                                getImagePath('bookings'),
                                'Bookings',
                                context,
                              ),
                            ),
                            Obx(
                              () => getHomeScreenIconButtonWithLabel(
                                getImagePath(
                                  'friends_${homePageController.isDog.value ? 'dog' : 'human'}',
                                ),
                                'Friends',
                                context,
                              ),
                            ),
                          ],
                        ),
                        ProfilePic(),
                        Column(
                          children: [
                            getHomeScreenIconButtonWithLabel(
                              getImagePath('calendar'),
                              'Calendar',
                              context,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: getHeight(20),
                              ),
                              child: getHomeScreenIconButtonWithLabel(
                                getImagePath('messages'),
                                'Messages',
                                context,
                              ),
                            ),
                            Obx(
                              () => getHomeScreenIconButtonWithLabel(
                                getImagePath(
                                  'request_${homePageController.isDog.value ? 'dog' : 'human'}',
                                ),
                                'Request',
                                context,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () =>
                        heightDivider(homePageController.isDog.value ? 30 : 40),
                  ),
                  Obx(
                    () =>
                        homePageController.isDog.value
                            ? explore(context)
                            : findAMember(context),
                  ),
                  heightDivider(30),
                ],
              ),
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: BottomBar()),
        ],
      ),
    );
  }
}
