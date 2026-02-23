import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/restaurant_provider.dart';
import 'providers/theme_provider.dart';
import 'services/api_service.dart';
import 'screens/restaurant_list_screen.dart';

void main() {

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(ApiService()),
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

      ],

      child: MyApp(),

    ),

  );

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(

      builder: (context, themeProvider, child) {

        return MaterialApp(

          debugShowCheckedModeBanner: false,

          theme: ThemeData.light(),

          darkTheme: ThemeData.dark(),

          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,

          home: RestaurantListScreen(),

        );

      },

    );

  }

}