import 'package:flutter/material.dart';

import '../models/restaurant_detail.dart';
import '../services/api_service.dart';
import 'restaurant_provider.dart';

class RestaurantDetailProvider extends ChangeNotifier {

  final ApiService apiService;
  final String id;

  RestaurantDetailProvider(
      this.apiService,
      this.id,
  ) {
    fetchDetail();
  }

  late RestaurantDetail restaurant;

  ResultState state = ResultState.loading;

  String message = "";

  Future<void> fetchDetail() async {

    try {

      state = ResultState.loading;
      notifyListeners();

      restaurant =
          await apiService.fetchDetail(id);

      state = ResultState.hasData;

    } catch (e) {

      state = ResultState.error;
      message = e.toString();

    }

    notifyListeners();

  }

}