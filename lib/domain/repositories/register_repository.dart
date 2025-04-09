import 'package:pet_app/data/request/register_request.dart';
import 'package:pet_app/domain/responses/register_response.dart'; 

abstract class RegisterRepository {
  Future<RegisterResponse> register({RegisterRequest requestRegister});
}
