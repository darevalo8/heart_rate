import 'dart:io';

import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:heart_rate/src/common/constants.dart';
import 'package:heart_rate/src/shared_preferences/config_app_preferences.dart';

class HomeRepository {
  final _helper = ApiBaseHelper();
  final _prefs = ConfigAppPreferences();

  Future<List<dynamic>> fetchHearRate() async {
    print(getDate());
    final responseData = await _helper.get(
      url: "1/user/-/activities/heart/date/${getDate()}/1d.json",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${_prefs.token}"
      }
    );
    // print('soyyyyy un response ${responseData["activities-heart"][0]["value"]["restingHeartRate"]}');
    return responseData["activities-heart"];
  }
}
