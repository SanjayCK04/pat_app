part of 'user_profile_widgets.dart';

class ProfileHeader extends GetView<UserProfileController> {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Back button and heading
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
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
                'My Profile',
                context,
                size: 20,
                weight: FontWeight.w500,
              ),
              Spacer(),
              InkWell(
                onTap: controller.toggleEditMode,
                child: Obx(() => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(12), 
                    vertical: getHeight(6)
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getWidth(20)),
                    gradient: controller.isEditMode.value 
                      ? orangeGradient 
                      : blueGradient,
                  ),
                  child: makeText(
                    controller.isEditMode.value ? 'Cancel' : 'Edit Profile',
                    context,
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                )),
              )
            ],
          ),
        ),
        heightDivider(20),
        // Profile picture
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withAlpha((0.1 * 255).floor()),
                blurRadius: getWidth(20),
                offset: Offset(8, -4),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: backgroundGradient,
            ),
            padding: EdgeInsets.all(getWidth(8)),
            child: Container(
              width: getWidth(120),
              height: getWidth(120),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: blueGradient,
                border: Border.all(color: Colors.white, width: getWidth(1)),
              ),
              child: Obx(() {
                // Prioritize profileData over userData
                final profileData = controller.profileData.value;
                final loginData = controller.userData.value;
                
                // Determine which data source to use
                final useProfileData = profileData != null;
                final dataAvailable = useProfileData || loginData != null;
                
                if (!dataAvailable) {
                  // Show default profile avatar when no data is available
                  return Center(
                    child: Icon(
                      Icons.person,
                      size: getWidth(60),
                      color: Colors.white.withOpacity(0.7),
                    ),
                  );
                }
                
                // Get the correct data
                final fname = useProfileData ? profileData.fname : loginData!.fname;
                final lname = useProfileData ? profileData.lname : loginData!.lname;
                final image = useProfileData ? profileData.image : loginData!.image;
                
                // Check if first and last name are empty
                final hasName = fname.isNotEmpty && lname.isNotEmpty;
                final initials = hasName ? (fname[0] + lname[0]).toUpperCase() : '?';
                
                return image.isEmpty
                  ? Center(
                      child: makeText(
                        initials,
                        context,
                        size: 36,
                        weight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    )
                  : ClipOval(
                      child: Image.network(
                        image,
                        width: getWidth(120),
                        height: getWidth(120),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: makeText(
                              initials,
                              context,
                              size: 36,
                              weight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    );
              }),
            ),
          ),
        ),
        heightDivider(15),
        // User name
        Obx(() {
          // Prioritize profileData over userData
          final profileData = controller.profileData.value;
          final loginData = controller.userData.value;
          
          // Determine which data source to use
          final useProfileData = profileData != null;
          final dataAvailable = useProfileData || loginData != null;
          
          if (!dataAvailable) {
            // Show placeholder text when no data is available
            return Column(
              children: [
                makeText(
                  'Profile',
                  context,
                  size: 24,
                  weight: FontWeight.w600,
                ),
                heightDivider(5),
                makeText(
                  'No profile data',
                  context,
                  size: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
            );
          }
          
          // Get the correct data
          final fname = useProfileData ? profileData.fname : loginData!.fname;
          final lname = useProfileData ? profileData.lname : loginData!.lname;
          final username = useProfileData ? profileData.username : loginData!.username;
          
          // Handle empty name fields
          final displayName = (fname.isEmpty && lname.isEmpty) ? 'User' : '$fname $lname';
          final displayUsername = username.isEmpty ? 'username' : username;
          
          return Column(
            children: [
              makeText(
                displayName,
                context,
                size: 24,
                weight: FontWeight.w600,
              ),
              heightDivider(5),
              makeText(
                '@$displayUsername',
                context,
                size: 16,
                color: Colors.white.withOpacity(0.7),
              ),
            ],
          );
        }),
      ],
    );
  }
} 