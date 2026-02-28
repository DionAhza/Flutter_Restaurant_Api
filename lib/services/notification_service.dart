import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  static final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// INIT (dipanggil di main)
  static Future<void> init() async {

    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  /// SHOW NOTIFICATION (dipakai WorkManager)
  static Future<void> showNotification() async {

    const NotificationDetails notificationDetails =
        NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_reminder_channel',
        'Daily Reminder',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      "Waktunya Makan Siang 🍽️",
      "Jangan lupa cek restaurant favorit kamu!",
      notificationDetails,
    );
  }

  /// SCHEDULE NOTIFICATION (tanpa WorkManager)
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
    await flutterLocalNotificationsPlugin.cancelAll();
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
            11);

    if (scheduledDate.isBefore(now)) {
      scheduledDate =
          scheduledDate.add(const Duration(minutes: 15));
          
    }

    return scheduledDate;
  }
}