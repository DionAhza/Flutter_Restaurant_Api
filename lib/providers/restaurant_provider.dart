import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/restaurant.dart';

enum ResultState { initial,loading, hasData,noData, error }

class RestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  RestaurantProvider(this.apiService);

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  List<Restaurant> _restaurants = [];
List<Restaurant> get restaurants => _restaurants;

  String _message = "";
  String get message => _message;

  Future<void> fetchRestaurants() async {

    try {

      _state = ResultState.loading;
      notifyListeners();

      final data = await apiService.fetchRestaurants();

    _restaurants = data;

      _state = ResultState.hasData;

    } catch (e) {

      _state = ResultState.error;
      _message = e.toString();

    }

    notifyListeners();

  }

}