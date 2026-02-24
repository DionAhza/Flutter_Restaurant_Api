import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/restaurant_detail_provider.dart';
import '../providers/restaurant_provider.dart';
import '../services/api_service.dart';
import '../widgets/loading_widget.dart';
import '../widgets/review_form.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(ApiService(), id),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Restaurant"),
        ),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return LoadingWidget();
            } else if (provider.state == ResultState.hasData) {
              final restaurant = provider.restaurant;

              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Hero(
                    tag: restaurant.id,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    restaurant.address,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    restaurant.city,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text("⭐ ${restaurant.rating}"),
                  SizedBox(height: 16),
                  Text(restaurant.description),
                  SizedBox(height: 16),
                  Text(
                    "Customer Reviews",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // ...restaurant.customerReviews.map(
                  //   (review) => ListTile(
                  //     title: Text(review.name),
                  //     subtitle: Text(review.review),
                  //   ),
                  // ),
                  SizedBox(height: 8),
                  Column(
                    children: restaurant.customerReviews.map<Widget>((review) {
                      return Card(
                        child: ListTile(
                          title: Text(review.name),
                          subtitle: Text(review.review),
                          trailing: Text(review.date),
                        ),
                      );
                    }).toList(),
                  ),
                  Text(
                    "Foods",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...restaurant.foods
                      .map((food) => Text("• ${food.name}")),
                      // .toList(),
                  SizedBox(height: 16),
                  Text(
                    "Drinks",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...restaurant.drinks
                      .map((drink) => Text("• ${drink.name}")),
                      // .toList(),
                  SizedBox(height: 20),
                  Text(
                    "Add Review",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ReviewForm(restaurantId: restaurant.id),
                ],
              );
            } else {
              return Center(
                child: Text(provider.message),
              );
            }
          },
        ),
      ),
    );
  }
}
