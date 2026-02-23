import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';
import '../models/restaurant_detail.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/restaurant_search_result.dart';

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev';

 Future<List<Restaurant>> fetchRestaurants() async {

  final response =
      await http.get(Uri.parse("$baseUrl/list"));

  if (response.statusCode == 200) {

    final jsonData = jsonDecode(response.body);

    List data = jsonData['restaurants'];

    return data
        .map((json) => Restaurant.fromJson(json))
        .toList();

  } else {

    throw Exception("Failed load");

  }

}

 Future<RestaurantDetail> fetchDetail(String id) async {

  final response =
      await http.get(Uri.parse("$baseUrl/detail/$id"));

  if (response.statusCode == 200) {

    final jsonData = jsonDecode(response.body);

    return RestaurantDetail.fromJson(
        jsonData['restaurant']);

  } else {

    throw Exception("Failed load detail");

  }

}

Future<RestaurantSearchResult> searchRestaurants(String query) async {

  final response = await http.get(
    Uri.parse(
      "https://restaurant-api.dicoding.dev/search?q=$query",
    ),
  );

  if (response.statusCode == 200) {

    return RestaurantSearchResult.fromJson(
      json.decode(response.body),
    );

  } else {

    throw Exception("Failed to search restaurant");

  }

}

Future<void> postReview({
  required String id,
  required String name,
  required String review,
}) async {

  final response = await http.post(

    Uri.parse("https://restaurant-api.dicoding.dev/review"),

    headers: {
      "Content-Type": "application/json",
    },

    body: json.encode({
      "id": id,
      "name": name,
      "review": review,
    }),

  );

  if (response.statusCode != 201) {

    throw Exception("Failed to post review");

  }

}
}
