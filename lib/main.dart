import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/restaurant_provider.dart';
import 'services/api_service.dart';
import 'screens/restaurant_list_screen.dart';

void main() {

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) =>
              RestaurantProvider(ApiService()),
        ),

      ],

      child: MyApp(),

    ),

  );

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: RestaurantListScreen(),

    );

  }

}