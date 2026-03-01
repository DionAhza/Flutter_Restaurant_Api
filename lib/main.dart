import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/providers/reminder_provider.dart';
// import 'package:restaurant_dicoding/services/background_service.dart';
import 'package:restaurant_dicoding/services/background_service.dart'
    as BackgroundService;
import 'package:restaurant_dicoding/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';
import 'providers/favorite_provider.dart';
import 'data/database_helper.dart';

import 'theme/app_theme.dart';
import 'providers/restaurant_provider.dart';
import 'providers/theme_provider.dart';
import 'services/api_service.dart';
import 'screens/restaurant_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Workmanager().initialize(
    BackgroundService.callbackDispatcher,
    isInDebugMode: true,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(DatabaseHelper()),
        ),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],

      child: const MyApp(), // WAJIB ADA
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const RestaurantListScreen(),
        );
      },
    );
  }
}
