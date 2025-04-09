import 'package:pet_app/domain/responses/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login({required String email, required String password});
}
