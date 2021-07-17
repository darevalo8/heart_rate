import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/src/app_bloc_observer.dart';
import 'package:heart_rate/src/dependencies.dart';

import 'package:heart_rate/modules/auth/pages/login_page.dart';
import 'package:heart_rate/src/shared_preferences/config_app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final configPrefs = ConfigAppPreferences();
  await configPrefs.initPrefs();

  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HeartRate',
        home: LoginPage(),
        theme: ThemeData(fontFamily: 'Poppins'),
      ),
    );
  }
}
