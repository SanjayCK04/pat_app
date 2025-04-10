class UpdateProfileResponse {
  final String status;
  final String message;
  final UpdateProfileData? data;

  UpdateProfileResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? UpdateProfileData.fromJson(json['data']) : null,
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

class UpdateProfileData {
  final String userId;
  final String fname;
  final String lname;
  final String email;
  final String username;

  UpdateProfileData({
    required this.userId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.username,
  });

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) {
    return UpdateProfileData(
      userId: json['user_id'] ?? '',
      fname: json['fname'] ?? '',
      lname: json['lname'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['fname'] = fname;
    data['lname'] = lname;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
} 