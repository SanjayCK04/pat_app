import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';
import 'package:pet_app/domain/repositories/login_repository.dart';
import 'package:pet_app/domain/responses/login_response.dart';

class LoginRepositoryImpl implements LoginRepository {
  final Dio _dio = Dio();
  
  LoginRepositoryImpl() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
    };
  }
  
  @override
  Future<LoginResponse> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '${Constant.baseUrl}/login',
        data: {
          'log': email,
          'password': password,
        },
      );
      print("login-response--${response.data}");  

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error
        try {
          return LoginResponse.fromJson(e.response?.data);
        } catch (_) {
          return LoginResponse(
            status: 'E',
            message: 'Server error: ${e.response?.statusMessage}',
          );
        }
      } else {
        // Something went wrong with the request
        return LoginResponse(
          status: 'E',
          message: 'Network error: ${e.message}',
        );
      }
    } catch (e) {
      // Generic error handling
      return LoginResponse(
        status: 'E',
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }
}
