import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';
import '../providers/restaurant_provider.dart';
import '../services/api_service.dart';
import '../screens/restaurant_detail_screen.dart';
import '../widgets/loading_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(ApiService()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Search Restaurant"),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Search restaurant...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<SearchProvider>().searchRealtime(value);
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<SearchProvider>(
                    builder: (context, provider, child) {
                      if (provider.state == ResultState.loading) {
                        return LoadingWidget();
                      }

                      if (provider.state == ResultState.hasData) {
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
                              subtitle: Text(restaurant.city),
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
                      }

                      if (provider.state == ResultState.noData) {
                        return Center(
                          child: Text(provider.message),
                        );
                      }

                      return const Center(
                        child: Text("Start typing to search"),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
