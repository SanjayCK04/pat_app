import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;

class UpdateProfileRequest {
  UpdateProfileRequest({
    required this.userId,
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
  });

  late final int userId;
  late final String fname;
  late final String lname;
  late final String username;
  late final String email;

  @override
  String toString() {
    return 'UpdateProfileRequest(userId: $userId, fname: $fname, lname: $lname, username: $username, email: $email)';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId.toString();
    _data['firstname'] = fname;
    _data['lastname'] = lname;
    _data['username'] = username;
    _data['email'] = email;
    return _data;
  }
}

class UpdateProfileService {
  final Dio _dio = Dio();

  Future<void> setupHeaders() async {
    String token = await HiveManager.readUserToken();
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
      'Y-AUTH-TOKEN': token,
    };
  }
} 