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
      final now = DateTime.now();
      final targetTime = DateTime(now.year, now.month, now.day, 11, 0);

      final initialDelay = targetTime.isBefore(now)
          ? targetTime.add(const Duration(days: 1)).difference(now)
          : targetTime.difference(now);

      await Workmanager().registerPeriodicTask(
        "dailyReminderTask",
        dailyTask,
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay, 
      );
    } else {
      await Workmanager().cancelByUniqueName("dailyReminderTask");
    }

    notifyListeners();
  }
}
