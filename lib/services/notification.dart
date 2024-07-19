import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("mipmap/ic_launcher");

    // ignore: prefer_const_constructors
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails("channelId", "channelName",
          importance: Importance.high,
          playSound: true,
          priority: Priority.high),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails());
  }
}
