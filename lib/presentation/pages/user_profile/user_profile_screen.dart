import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/constants/constants.dart';
import 'package:pet_app/core/widgets/common_widgets.dart';
import 'package:pet_app/presentation/controllers/user_profile_controller.dart';
import 'package:pet_app/presentation/pages/user_profile/widgets/user_profile_widgets.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) { 

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isDataLoaded.value) {
        controller.loadUserData();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(gradient: backgroundGradient),
              child: Obx(() { 
                if (controller.isLoading.value && !controller.isDataLoaded.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 16),
                        makeText(
                          "Loading profile...",
                          context,
                          size: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                  );
                }
                
                // Show no data view if data couldn't be loaded
                if (controller.isDataLoaded.value && 
                    controller.profileData.value == null && 
                    controller.userData.value == null) {
                  return _buildNoDataView(context);
                }
                
                // Data is available - show with refresh capability
                return RefreshIndicator(
                  onRefresh: controller.loadUserData,
                  color: baseOrangeColor,
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView( 
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        heightDivider(20),
                        const ProfileHeader(),
                        heightDivider(20),  
                        controller.isEditMode.value
                            ? const EditProfileForm()
                            : Column(
                                children: const [
                                  ProfileInfoCard(title: 'Basic Information'),
                                  ProfileInfoCard(title: 'Verification'),
                                  ProfileInfoCard(title: 'Referral'),
                                  SizedBox(height: 20),
                                ],
                              ), 
                        if (!controller.isEditMode.value) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(20),
                              vertical: getHeight(10),
                            ),
                            child: makeFilledButton(
                              makeText(
                                'Logout',
                                context,
                                size: 18,
                                weight: FontWeight.w500,
                              ),
                              controller.logout,
                              context,
                              gradient: orangeGradient,
                              margin: EdgeInsets.zero,
                            ),
                          ),
                          // Add some extra space to ensure content is scrollable for refresh
                          heightDivider(120),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ), 
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomBar(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNoDataView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.loadUserData,
      color: baseOrangeColor,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: Get.height - 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 80,
                  color: Colors.white.withOpacity(0.7),
                ),
                SizedBox(height: 16),
                makeText(
                  "No profile data available",
                  context,
                  size: 18,
                  weight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: Get.width * 0.8,
                  child: makeText(
                    "Pull down to refresh or try again later",
                    context,
                    size: 14,
                    align: TextAlign.center,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 24),
                makeFilledButton(
                  makeText(
                    'Retry',
                    context,
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                  () => controller.loadUserData(),
                  context,
                  width: 120,
                  height: 45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
