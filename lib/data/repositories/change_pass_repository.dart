import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';
import 'package:pet_app/domain/repositories/change_pass_repository.dart';
import 'package:pet_app/domain/responses/change_pass_response.dart'; 
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final Dio _dio = Dio();
  
  ChangePasswordRepositoryImpl() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
    };
  }
  
  Future<void> _setupAuthHeaders() async {
    String token = await HiveManager.readUserToken();
    print("Using token for auth: $token");
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'API-TOKEN': Constant.baseToken,
      'Y-AUTH-TOKEN': token,
    };
    print("Headers set: ${_dio.options.headers}");
  }
  
  @override
  Future<ChangePasswordResponse> changePassword({required String passwordOld, required String passwordNew}) async {
    try {
      // Set up authentication headers
      await _setupAuthHeaders();
      
      // Read user ID
      int userId = await HiveManager.readUserId() ?? 180;
      
      final data = {
        'user_id': userId.toString(),
        'old_password': passwordOld,
        'password': passwordNew,
        'confirm_password': passwordNew,
      };
      
      print("Sending change password request: $data");
      
      final response = await _dio.post(
        '${Constant.baseUrl}/change-password',
        data: data,
        options: Options(
          headers: _dio.options.headers,
          validateStatus: (status) => true, // Accept all status codes to handle errors manually
        ),
      );
      
      print("change-password-response code: ${response.statusCode}");
      print("change-password-response data: ${response.data}");

      // Check if response is valid
      if (response.data is! Map<String, dynamic>) {
        print("Invalid response format: ${response.data.runtimeType}");
        return ChangePasswordResponse(
          status: 'E',
          message: 'Invalid response format from server',
        );
      }
      
      // Extract detailed validation errors if available
      final Map<String, dynamic> responseData = response.data;
      if (responseData.containsKey('errors') && responseData['errors'] is Map) {
        final Map<String, dynamic> errors = responseData['errors'];
        final List<String> errorMessages = [];
        
        errors.forEach((field, messages) {
          if (messages is List) {
            for (var message in messages) {
              errorMessages.add('$field: $message');
            }
          } else if (messages is String) {
            errorMessages.add('$field: $messages');
          }
        });
        
        if (errorMessages.isNotEmpty) {
          return ChangePasswordResponse(
            status: 'E',
            message: errorMessages.join(', '),
          );
        }
      }

      // Try to parse the response
      try {
        return ChangePasswordResponse.fromJson(response.data);
      } catch (e) {
        // If parsing fails, create a basic response
        final bool isSuccess = response.statusCode == 200 && 
            (responseData['status'] == 'S' || responseData['status'] == 'SUCCESS');
        
        return ChangePasswordResponse(
          status: isSuccess ? 'S' : 'E',
          message: responseData['message'] ?? (isSuccess ? 'Password changed successfully' : 'Failed to change password'),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error
        try {
          return ChangePasswordResponse.fromJson(e.response?.data);
        } catch (_) {
          return ChangePasswordResponse(
            status: 'E',
            message: 'Server error: ${e.response?.statusMessage}',
          );
        }
      } else {
        // Something went wrong with the request
        return ChangePasswordResponse(
          status: 'E',
          message: 'Network error: ${e.message}',
        );
      }
    } catch (e) {
      // Generic error handling
      return ChangePasswordResponse(
        status: 'E',
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }
}
