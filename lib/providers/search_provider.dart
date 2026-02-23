import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';
import 'restaurant_provider.dart';


class SearchProvider extends ChangeNotifier {
 
  final ApiService apiService;

  SearchProvider(this.apiService);

  ResultState _state = ResultState.initial;
  ResultState get state => _state;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  String _message = '';
  String get message => _message;

  Timer? _debounce;

  Future<void> search(String query) async {

    if (query.isEmpty) {

      _state = ResultState.initial;
      _restaurants = [];
      notifyListeners();
      return;

    }

    try {

      _state = ResultState.loading;
      notifyListeners();

      final result =
          await apiService.searchRestaurants(query);

      if (result.restaurants.isEmpty) {

        _state = ResultState.noData;
        _message = "Restaurant tidak ditemukan";

      } else {

        _state = ResultState.hasData;
        _restaurants = result.restaurants;

      }

    } catch (e) {

      _state = ResultState.error;
      _message = "Gagal mencari restaurant";

    }

    notifyListeners();

  }

  void searchRealtime(String query) {

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce =
        Timer(const Duration(milliseconds: 500), () {

      search(query);

    });

  }

}