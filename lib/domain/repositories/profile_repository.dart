import 'package:pet_app/domain/responses/profile_response.dart';
import 'package:pet_app/domain/responses/update_profile_response.dart';

abstract class ProfileRepository {
  Future<ProfileResponse> getProfile({required int userId});
  Future<UpdateProfileResponse> updateProfile({
    required int userId,
    required String fname,
    required String lname,
    required String username,
    required String email,
  });
} 