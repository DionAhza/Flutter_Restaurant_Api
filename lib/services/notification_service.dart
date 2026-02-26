import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {

    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  static Future<void> scheduleDailyReminder() async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Waktunya Makan Siang 🍽️",
      "Jangan lupa cek restaurant favorit kamu!",
      _nextInstanceOf11AM(),

      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,

      androidScheduleMode:
          AndroidScheduleMode.exactAllowWhileIdle,

      matchDateTimeComponents:
          DateTimeComponents.time,
    );
  }

  static Future<void> cancelReminder() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  static tz.TZDateTime _nextInstanceOf11AM() {

    final tz.TZDateTime now =
        tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(
            tz.local,
            now.year,
            now.month,
            now.day,
            now.hour,
            now.minute,
            now.second + 10
            );

    if (scheduledDate.isBefore(now)) {
      scheduledDate =
          scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}