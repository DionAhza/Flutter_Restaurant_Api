import 'restaurant.dart';

class RestaurantSearchResult {

  final List<Restaurant> restaurants;

  RestaurantSearchResult({required this.restaurants});

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) {

    List<Restaurant> restaurants = [];

    if (json['restaurants'] != null) {

      restaurants = List<Restaurant>.from(
        json['restaurants'].map(
          (x) => Restaurant.fromJson(x),
        ),
      );

    }

    return RestaurantSearchResult(
      restaurants: restaurants,
    );

  }

}