 

import 'package:pet_app/domain/responses/change_pass_response.dart';

abstract class ChangePasswordRepository {
  Future<ChangePasswordResponse> changePassword({required String passwordOld, required String passwordNew});
}
