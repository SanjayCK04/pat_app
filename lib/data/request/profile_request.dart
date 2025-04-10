import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';

class ProfileRequest {
  ProfileRequest({
    required this.userId,
  });

  late final int userId;

  @override
  String toString() {
    return 'ProfileRequest(userId: $userId)';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    return _data;
  }
}

class ProfileService {
  final Dio _dio = Dio();

  ProfileService() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
    };
  }
} 