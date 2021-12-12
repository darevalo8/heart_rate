import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:heart_rate/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  static const channelId = "123";
  static const appName = "Heart Rate";
  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    print("pregundamos algoo o que $payload");
    selectNotificationSubject.add(payload);
    
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print("object");
  }

  void scheduleAlarm(String payload) async {
    tz.initializeTimeZones();
    var schedule = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    var androidNotification =
        AndroidNotificationDetails(channelId, appName, "cosita");
    var iosNotification = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var platformSpecific =
        NotificationDetails(android: androidNotification, iOS: iosNotification);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, appName, "Anomalía Detectada", schedule, platformSpecific,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true, payload: payload);
    // await flutterLocalNotificationsPlugin.show(0, 'Anomalia', "Te vas a morir loco", platformSpecific);
  }
}
