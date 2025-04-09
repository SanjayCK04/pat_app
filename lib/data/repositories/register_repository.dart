import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';
import 'package:pet_app/data/request/register_request.dart'; 
import 'package:pet_app/domain/repositories/register_repository.dart'; 
import 'package:pet_app/domain/responses/register_response.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final Dio _dio = Dio();
  
  RegisterRepositoryImpl() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
    };
  }
  
  @override
  Future<RegisterResponse> register({RegisterRequest? requestRegister}) async {
    try {
      final response = await _dio.post(
        '${Constant.baseUrl}/register',
        data: requestRegister?.toJson(),
      );
      print("register-response--${response.data}");  

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error
        try {
          return RegisterResponse.fromJson(e.response?.data);
        } catch (_) {
          return RegisterResponse(
            status: 'E',
            message: 'Server error: ${e.response?.statusMessage}',
          );
        }
      } else {
        // Something went wrong with the request
        return RegisterResponse(
          status: 'E',
          message: 'Network error: ${e.message}',
        );
      }
    } catch (e) {
      // Generic error handling
      return RegisterResponse(
        status: 'E',
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }
}
