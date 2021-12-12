import 'dart:io';

import 'package:heart_rate/modules/user/user_model.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:heart_rate/src/shared_preferences/config_app_preferences.dart';

class UserRepository {
  final _helper = ApiBaseHelper();
  final _prefs = ConfigAppPreferences();

  Future<User> fetchProfile() async {
    final responseData = await _helper.get(
      url: "1/user/-/profile.json",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${_prefs.token}"
      }
    );
    final user = User.fromJsonMap(responseData['user']);
    return user;
  }
}
