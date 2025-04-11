class ChangePasswordResponse {
  final String status;
  final String message;

  ChangePasswordResponse({required this.status, required this.message});
  
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      status: json['status'] ?? 'E',
      message: json['message'] ?? 'Unknown error occurred',
    );
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}