import 'package:shared_preferences/shared_preferences.dart';

class ConfigAppPreferences {
  static final ConfigAppPreferences  _instance = new ConfigAppPreferences._internal();

  factory ConfigAppPreferences() {
    return _instance;
  }

  ConfigAppPreferences._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  

  String get token {
    return _prefs!.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs!.setString('token', value);
  }
  String get userID {
    return _prefs!.getString('userID') ?? '';
  }

  set userID( String value ) {
    _prefs!.setString('userID', value);
  }

}