import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_provider.dart';
import 'restaurant_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurants"),
      ),

      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {

          /// loading awal
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text("Belum ada restaurant favorit"),
            );
          }

          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {

              final restaurant = provider.favorites[index];

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(

                  leading: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                    width: 60,
                    fit: BoxFit.cover,
                  ),

                  title: Text(restaurant.name),

                  subtitle: Text(
                    "${restaurant.city} • ⭐ ${restaurant.rating}",
                  ),

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

                ),
              );

            },
          );

        },
      ),
    );
  }
}