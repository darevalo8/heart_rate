import 'package:heart_rate/modules/auth/domain/repositories.dart';
import 'package:heart_rate/src/shared_preferences/config_app_preferences.dart';

class LoginUseCase {
  final _authRepository = AuhtRepository();
  final _prefs = ConfigAppPreferences();

  Future<bool> login() async {
    bool response = false;

    final data = await this._authRepository.auhtlogin();
    print("response data $data");
    if (data.containsKey('access_token') && data.containsKey('user_id')) {
      response = true;
      _prefs.token = data["access_token"];
      _prefs.userID = data["user_id"];
    }
    return response;
  }
}
