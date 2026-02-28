import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/services/notification_service.dart';

import '../providers/theme_provider.dart';
import '../providers/reminder_provider.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider = context.watch<ThemeProvider>();

    final reminderProvider = context.watch<ReminderProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(

        children: [

          /// DARK MODE
          SwitchListTile(

            title: const Text("Dark Theme"),

            value: themeProvider.isDarkMode,

            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },

          ),

          /// DAILY REMINDER
          SwitchListTile(

            title: const Text("Daily Reminder (11:00 AM)"),

            subtitle:
                const Text("Reminder untuk makan siang"),

            value: reminderProvider.isReminderActive,

            onChanged: (value) {
              reminderProvider.toggleReminder(value);
            },

          ),
          ElevatedButton(
    onPressed: () async {
      await NotificationService.showNotification();
        },
       child: const Text("Test Notification"),
      )

        ],

      ),

    );
  }
}