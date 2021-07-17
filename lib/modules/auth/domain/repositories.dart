import 'package:flutter/services.dart';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:heart_rate/src/common/constants.dart';

// import 'package:heart_rate/src/common/api_fetch.dart';
// import 'package:heart_rate/src/shared_preferences/config_app_preferences.dart';

class AuhtRepository {
  // final _prefs = ConfigAppPreferences();
  // final _helper = ApiBaseHelper();

  Future<Map<String, dynamic>> auhtlogin() async {
    final url = getFitbitUrl();
    final callbackUrlScheme = 'mi-cameo.firebaseapp';
    Map<String, dynamic> response = {};
    try {
      final result = await FlutterWebAuth.authenticate(
          url: url, callbackUrlScheme: callbackUrlScheme);
      
      // Extract token from resulting url
      final urlParsed = result.replaceFirst('#', '?');
      final token = Uri.parse(urlParsed).queryParameters['access_token'];
      final userId = Uri.parse(urlParsed).queryParameters['user_id'];
      response['access_token'] = token;
      response['user_id'] = userId;
    } on PlatformException catch (e) {
      print(e);
    }
    return response;
  }

  
}
