class ProfileResponse {
  final String status;
  final String message;
  final ProfileData? data;

  ProfileResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  final String userId;
  final String fname;
  final String lname;
  final String email;
  final String image;
  final String coverImage;
  final String token;
  final String utype;
  final String username;
  final String myReferralCode;
  final String isEmailVerified;
  final String isGovtIdVerified;

  ProfileData({
    required this.userId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.image,
    required this.coverImage,
    this.token = '',
    required this.utype,
    required this.username,
    required this.myReferralCode,
    required this.isEmailVerified,
    required this.isGovtIdVerified,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      userId: json['id']?.toString() ?? '0',
      fname: json['fname'] ?? '',
      lname: json['lname'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      coverImage: json['coverimage'] ?? '',
      token: json['token'] ?? '',
      utype: json['utype'] ?? '',
      username: json['username'] ?? '',
      myReferralCode: json['my_referral_code'] ?? '',
      isEmailVerified: json['isemailverified'] ?? '',
      isGovtIdVerified: json['isgovtidverified'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = userId;
    data['fname'] = fname;
    data['lname'] = lname;
    data['email'] = email;
    data['image'] = image;
    data['coverimage'] = coverImage;
    data['token'] = token;
    data['utype'] = utype;
    data['username'] = username;
    data['my_referral_code'] = myReferralCode;
    data['isemailverified'] = isEmailVerified;
    data['isgovtidverified'] = isGovtIdVerified;
    return data;
  }
} 