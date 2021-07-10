import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_web_auth/flutter_web_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = '';

  void authenticate() async {
    final url =
        'https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=22BYPV&redirect_uri=mi-cameo.firebaseapp://fitbit&scope=activity%20nutrition%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight';
    final callbackUrlScheme = 'mi-cameo.firebaseapp';

    try {
      final result = await FlutterWebAuth.authenticate(
          url: url, callbackUrlScheme: callbackUrlScheme);
      print("salio todo correcto $result");
      // Extract code from resulting url
      final code = Uri.parse(result).queryParameters['code'];
      setState(() {
        _status = 'Got result: $code';
      });
    } on PlatformException catch (e) {
      setState(() {
        _status = 'Got error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeartRate',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Status: $_status\n'),
              const SizedBox(height: 80),
              ElevatedButton(
                child: Text('Enlaza Tú reloj'),
                onPressed: () {
                  this.authenticate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
