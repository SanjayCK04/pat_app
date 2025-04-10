part of 'user_profile_widgets.dart';

class ProfileInfoCard extends GetView<UserProfileController> {
  final String title;
  
  const ProfileInfoCard({
    Key? key,
    required this.title,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(20), vertical: getHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          makeText(
            title,
            context,
            size: 18,
            weight: FontWeight.w500,
          ),
          heightDivider(10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(getWidth(15)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getWidth(10)),
              color: Color.fromARGB((0.15 * 255).floor(), 96, 170, 254),
            ),
            child: Obx(() { 
              final profileData = controller.profileData.value;
              final loginData = controller.userData.value;
               
              final useProfileData = profileData != null;
              final dataAvailable = useProfileData || loginData != null;
              
              if (!dataAvailable) {
                // Show 'No Data' message with icon instead of loading indicator
                return _buildNoDataView(context);
              }
               
              final email = useProfileData ? profileData.email : loginData!.email;
              final username = useProfileData ? profileData.username : loginData!.username;
              final utype = useProfileData ? profileData.utype : loginData!.utype;
              final isEmailVerified = useProfileData ? profileData.isEmailVerified : loginData!.isEmailVerified;
              final isGovtIdVerified = useProfileData ? profileData.isGovtIdVerified : loginData!.isGovtIdVerified;
              final myReferralCode = useProfileData ? profileData.myReferralCode : loginData!.myReferralCode;
              
              if (title == 'Basic Information') {
                return Column(
                  children: [
                    _buildInfoRow(context, 'Email', email.isNotEmpty ? email : 'Not available'),
                    _buildDivider(),
                    _buildInfoRow(context, 'Username', username.isNotEmpty ? username : 'Not available'),
                    _buildDivider(),
                    _buildInfoRow(context, 'User Type', utype.isNotEmpty ? utype.toUpperCase() : 'Not available'),
                  ],
                );
              } else if (title == 'Verification') {
                return Column(
                  children: [
                    _buildInfoRow(
                      context, 
                      'Email Verified', 
                      isEmailVerified == '1' || isEmailVerified == 'Y' ? 'Yes' : 'No',
                      valueColor: isEmailVerified == '1' || isEmailVerified == 'Y' ? Colors.green : Colors.red,
                    ),
                    _buildDivider(),
                    _buildInfoRow(
                      context, 
                      'ID Verified', 
                      isGovtIdVerified == '1' || isGovtIdVerified == 'Y' ? 'Yes' : 'No',
                      valueColor: isGovtIdVerified == '1' || isGovtIdVerified == 'Y' ? Colors.green : Colors.red,
                    ),
                  ],
                );
              } else if (title == 'Referral') {
                return Column(
                  children: [
                    _buildInfoRow(context, 'My Referral Code', myReferralCode.isNotEmpty ? myReferralCode : 'Not available'),
                  ],
                );
              }
              
              return Container();
            }),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNoDataView(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getHeight(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: getWidth(40),
            color: Colors.white.withOpacity(0.7),
          ),
          heightDivider(10),
          makeText(
            'No data available',
            context,
            size: 16,
            color: Colors.white.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(
    BuildContext context, 
    String label, 
    String value, 
    {Color? valueColor}
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeText(
            label,
            context,
            size: 14,
            weight: FontWeight.w500,
            color: baseOrangeColor,
          ),
          makeText(
            value,
            context,
            size: 14,
            weight: FontWeight.w400,
            color: valueColor ?? Colors.white,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(5)),
      child: Divider(
        color: Colors.white.withOpacity(0.1),
        thickness: getHeight(1),
      ),
    );
  }
} 