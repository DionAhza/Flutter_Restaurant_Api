import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/restaurant.dart';
import '../models/restaurant_detail.dart';
import '../models/restaurant_search_result.dart';

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev';

  
  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/list"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List data = jsonData['restaurants'];

        return data.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }

    } on SocketException {
      throw Exception("Tidak ada koneksi internet");

    } on TimeoutException {
      throw Exception("Koneksi timeout");

    } catch (e) {
      throw Exception("Error fetchRestaurants: $e");
    }
  }

 
  Future<RestaurantDetail> fetchDetail(String id) async {
    
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/detail/$id"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return RestaurantDetail.fromJson(jsonData['restaurant']);
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }

    } on SocketException {
      throw Exception("Tidak ada koneksi internet");

    } on TimeoutException {
      throw Exception("Koneksi timeout");

    } catch (e) {
      throw Exception("Error fetchDetail: $e");
    }
  }

  
  Future<RestaurantSearchResult> searchRestaurants(String query) async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/search?q=$query"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return RestaurantSearchResult.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }

    } on SocketException {
      throw Exception("Tidak ada koneksi internet");

    } on TimeoutException {
      throw Exception("Koneksi timeout");

    } catch (e) {
      throw Exception("Error searchRestaurants: $e");
    }
  }

 
  Future<void> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/review"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "id": id,
              "name": name,
              "review": review,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 201) {
        throw Exception("Gagal mengirim review");
      }

    } on SocketException {
      throw Exception("Tidak ada koneksi internet");

    } on TimeoutException {
      throw Exception("Koneksi timeout");

    } catch (e) {
      throw Exception("Error postReview: $e");
    }
  }
}