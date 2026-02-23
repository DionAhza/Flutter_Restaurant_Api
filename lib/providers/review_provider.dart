import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'restaurant_provider.dart';

class ReviewProvider extends ChangeNotifier {

  final ApiService apiService;

  ReviewProvider(this.apiService);

  ResultState _state = ResultState.initial;

  ResultState get state => _state;

  String _message = "";

  String get message => _message;

  Future<void> postReview({
    required String id,
    required String name,
    required String review,
  }) async {

    try {

      _state = ResultState.loading;
      notifyListeners();

      await apiService.postReview(
        id: id,
        name: name,
        review: review,
      );

      _state = ResultState.hasData;

    } catch (e) {

      _state = ResultState.error;
      _message = "Gagal mengirim review";

    }

    notifyListeners();

  }

}