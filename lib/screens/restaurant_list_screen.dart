import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/screens/favorite_screen.dart';
import 'package:restaurant_dicoding/screens/settings_screen.dart';

import '../providers/theme_provider.dart';
import 'search_screen.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/loading_widget.dart';
import '../screens/restaurant_detail_screen.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});
  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();

}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.microtask(() {
      if (!mounted) return;

      context.read<RestaurantProvider>().fetchRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant App"),
        actions: [
           IconButton(
      icon: const Icon(Icons.settings),

      onPressed: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SettingsScreen(),
          ),
        );

      },
    ),
          
          IconButton(
      icon: const Icon(Icons.favorite),
      onPressed: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FavoriteScreen(),
          ),
        );
      },
    ),
          
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchScreen(),
                ),
              );
            },
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Row(
                children: [
                  Icon(Icons.light_mode),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: themeProvider.toggleTheme,
                  ),
                  Icon(Icons.dark_mode),
                  
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return LoadingWidget();
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = provider.restaurants[index];

                return ListTile(
                  leading: Hero(
                    tag: restaurant.id,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                      width: 60,
                    ),
                  ),
                  title: Text(restaurant.name),
                  subtitle: Text("${restaurant.city} ⭐ ${restaurant.rating}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailScreen(
                          id: restaurant.id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
