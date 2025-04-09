import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/utils/utility_functions.dart';
import 'package:pet_app/core/widgets/common_widgets.dart';
import 'package:pet_app/presentation/pages/profile/widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(gradient: backgroundGradient),
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightDivider(10),
                  Row(
                    children: [
                      SizedBox(
                        width: getHeight(30),
                        height: getHeight(30),
                        child: IconButton(
                          onPressed: () => Get.back(),
                          color: Colors.black,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withAlpha(
                              (0.8 * 255).toInt(),
                            ),
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
                        'Profile',
                        context,
                        size: 20,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  heightDivider(20),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: getWidth(350),
                            height: getHeight(204),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(getWidth(10)),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: ClipRect(
                              child: Obx(
                                () => Image.asset(
                                  dogsController.dog.value.images[0],
                                  height: getHeight(204),
                                  width: getWidth(350),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Positioned(
                              top: getHeight(10),
                              right: getWidth(10),
                              child: Row(
                                children: [
                                  if (currentDog.id !=
                                      dogsController.dog.value.id)
                                    Obx(
                                      () => MakeProfileIcon(
                                        dogsController.isLiked.value
                                            ? getImagePath('heart_icon_filled')
                                            : getImagePath('heart_icon'),
                                        dogsController.changeLike,
                                      ),
                                    ),

                                  if (currentDog.id !=
                                      dogsController.dog.value.id)
                                    widthDivider(14),
                                  MakeProfileIcon(
                                    getImagePath('share_icon'),
                                    () {},
                                  ),
                                  if (currentDog.id !=
                                      dogsController.dog.value.id)
                                    widthDivider(14),
                                  if (currentDog.id !=
                                      dogsController.dog.value.id)
                                    MakeProfileIcon(
                                      getImagePath('messages'),
                                      () {},
                                    ),
                                  if (currentDog.id !=
                                      dogsController.dog.value.id)
                                    widthDivider(14),
                                  if (currentDog.id !=
                                      dogsController.dog.value.id)
                                    MakeProfileIcon(
                                      getImagePath('request_human'),
                                      () {},
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => Row(
                            children: [
                              for (
                                int i = 1;
                                i < dogsController.dog.value.images.length;
                                i++
                              )
                                Container(
                                  margin: EdgeInsets.only(
                                    left: i == 1 ? 0 : getWidth(8),
                                    right:
                                        i ==
                                                dogsController
                                                        .dog
                                                        .value
                                                        .images
                                                        .length -
                                                    1
                                            ? 0
                                            : getWidth(8),
                                    top: getHeight(10),
                                  ),
                                  width: getWidth(106),
                                  height: getHeight(72),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                      getWidth(10),
                                    ),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: ClipRect(
                                    child: Image.asset(
                                      dogsController.dog.value.images[i],
                                      height: getHeight(72),
                                      width: getWidth(107),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightDivider(15),
                  makeText(
                    'Basic Info',
                    context,
                    size: 20,
                    weight: FontWeight.w500,
                  ),
                  heightDivider(10),
                  Obx(
                    () => Row(
                      children: [
                        basicInfoContainer('Type', 'Dog', context),
                        widthDivider(25),
                        basicInfoContainer(
                          'Gender',
                          dogsController.dog.value.gender ? 'Male' : 'Female',
                          context,
                        ),
                        widthDivider(25),
                        basicInfoContainer(
                          'Age',
                          dogsController.dog.value.age,
                          context,
                        ),
                      ],
                    ),
                  ),
                  heightDivider(20),
                  Obx(
                    () => moreInformationContainer(
                      context,
                      dogsController.dog.value,
                    ),
                  ),
                  heightDivider(12),
                  currentDog == dogsController.dog.value
                      ? Container()
                      : Center(
                        child: makeFilledButton(
                          makeText(
                            'Friend Request',
                            context,
                            size: 14,
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          () {},
                          context,
                          padding: EdgeInsets.symmetric(
                            vertical: getHeight(7),
                            horizontal: getWidth(18),
                          ),
                          width: getWidth(131),
                          height: getHeight(31) < 40 ? 40 : getHeight(31),
                          borderRadius: BorderRadius.circular(getWidth(6)),
                          shadow: [BoxShadow(color: Colors.transparent)],
                        ),
                      ),
                  heightDivider(100),
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
