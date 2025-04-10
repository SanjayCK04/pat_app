import 'package:dio/dio.dart';
import 'package:pet_app/core/constants/base_url.dart';
import 'package:pet_app/data/request/profile_request.dart';
import 'package:pet_app/data/request/update_profile_request.dart';
import 'package:pet_app/domain/repositories/profile_repository.dart';
import 'package:pet_app/domain/responses/profile_response.dart';
import 'package:pet_app/domain/responses/update_profile_response.dart';
import 'package:pet_app/data/data_sources/local/hive_manager.dart' as HiveManager;

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio _dio = Dio();
  
  ProfileRepositoryImpl() {
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
  Future<ProfileResponse> getProfile({required int userId}) async {
    try {
      final response = await _dio.post(
        '${Constant.baseUrl}/get-profile',
        data: ProfileRequest(userId: userId).toJson(),
      );
      print("profile-response--${response.data}");  

      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("profile-error--${e.response?.data}");
      if (e.response != null) {
        // The server responded with an error
        try {
          return ProfileResponse.fromJson(e.response?.data);
        } catch (_) {
          return ProfileResponse(
            status: 'E',
            message: 'Server error: ${e.response?.statusMessage}',
          );
        }
      } else {
        print("profile-error-33-${e.message}");
        // Something went wrong with the request
        return ProfileResponse(
          status: 'E',
          message: 'Network error: ${e.message}',
        );
      }
    } catch (e) {
      // Generic error handling
      print("profile-error-44-${e.toString()}");
      return ProfileResponse(
        status: 'E',
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }
  
  @override
  Future<UpdateProfileResponse> updateProfile({
    required int userId,
    required String fname,
    required String lname,
    required String username,
    required String email,
  }) async {
    try {
      // Set up auth headers for this request
      await _setupAuthHeaders();
      
      // Create the request body
      final requestData = UpdateProfileRequest(
        userId: userId,
        fname: fname,
        lname: lname,
        username: username,
        email: email,
      ).toJson();
      
      print("Sending update profile request: $requestData");
      print("Request URL: ${Constant.baseUrl}/update-profile");
      
      final response = await _dio.post(
        '${Constant.baseUrl}/update-profile',
        data: requestData,
        options: Options(
          headers: _dio.options.headers,
          validateStatus: (status) => true, // Accept all status codes to handle errors manually
        ),
      );
      
      print("Update profile status code: ${response.statusCode}");
      print("Update profile raw response: ${response.data}");
      
      // Check if response is valid
      if (response.data is! Map<String, dynamic>) {
        print("Invalid response format: ${response.data.runtimeType}");
        return UpdateProfileResponse(
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
          return UpdateProfileResponse(
            status: 'E',
            message: errorMessages.join(', '),
          );
        }
      }

      return UpdateProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("update-profile-error--${e.response?.statusCode}");
      print("update-profile-error--${e.response?.data}");
      if (e.response != null) {
        // The server responded with an error
        try {
          return UpdateProfileResponse.fromJson(e.response?.data);
        } catch (_) {
          return UpdateProfileResponse(
            status: 'E',
            message: 'Server error: ${e.response?.statusMessage}',
          );
        }
      } else {
        print("update-profile-error--${e.message}");
        // Something went wrong with the request
        return UpdateProfileResponse(
          status: 'E',
          message: 'Network error: ${e.message}',
        );
      }
    } catch (e) {
      // Generic error handling
      print("update-profile-error--${e.toString()}");
      return UpdateProfileResponse(
        status: 'E',
        message: 'An error occurred: ${e.toString()}',
      );
    }
  }
} 