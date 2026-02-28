  import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/services/background_service.dart';
  import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
 

  class ReminderProvider extends ChangeNotifier {

    static const String _key = "daily_reminder";

    bool _isReminderActive = false;

    bool get isReminderActive => _isReminderActive;

    ReminderProvider() {
      loadReminder();
    }

    Future<void> loadReminder() async {

      final prefs = await SharedPreferences.getInstance();

      _isReminderActive = prefs.getBool(_key) ?? false;

      notifyListeners();
    }

   Future<void> toggleReminder(bool value) async {

  final prefs = await SharedPreferences.getInstance();

  _isReminderActive = value;

  await prefs.setBool(_key, value);

  if (value) {

    await Workmanager().registerPeriodicTask(
      "dailyReminderTask",
      dailyTask,
      frequency: const Duration(minutes: 15), // minimal android
      initialDelay: const Duration(seconds: 10), // untuk testing cepat
    );

  } else {

    await Workmanager().cancelByUniqueName("dailyReminderTask");
  }

  notifyListeners();
}
  }