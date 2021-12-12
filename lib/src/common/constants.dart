import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String apiFitbit = "api.fitbit.com";

final debug = false; //  true para local y false para produccion 

final String fITBITURL = "https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=22BYPV&redirect_uri=mi-cameo.firebaseapp://fitbit&scope=activity%20nutrition%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight&expires_in=31536000";
final now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String date = formatter.format(now.subtract(Duration(days:1)));
String getDate(){
  return date;
}
String getFitbitUrl(){
  return fITBITURL;
}
String getEnvironment(){

  return apiFitbit;
}


Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}