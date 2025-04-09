import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';

class RegisterRequest {
  RegisterRequest({
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
    required this.password,
  });

  late final String fname;
  late final String lname;
  late final String username;
  late final String email;
  late final String password;

  @override
  String toString() {
    return 'RegisterRequest(fname: $fname, lname: $lname, username: $username, email: $email, password: $password)';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fname'] = fname;
    _data['lname'] = lname;
    _data['signup_username'] = username;
    _data['signup_email'] = email;
    _data['signup_password'] = password;
    return _data;
  }
}

class RegisterService {
  final Dio _dio = Dio();

  RegisterService() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
    };
  }
}


