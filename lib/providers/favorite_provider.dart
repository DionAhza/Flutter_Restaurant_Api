import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/favorite_restaurant.dart';

class FavoriteProvider extends ChangeNotifier {

  final DatabaseHelper databaseHelper;

  FavoriteProvider(this.databaseHelper) {
    loadFavorites();
  }

  List<FavoriteRestaurant> _favorites = [];

  List<FavoriteRestaurant> get favorites => _favorites;

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  Future<void> loadFavorites() async {

    _favorites = await databaseHelper.getFavorites();

    notifyListeners();
  }

  Future<void> checkFavorite(String id) async {

    _isFavorite = await databaseHelper.isFavorite(id);

    notifyListeners();
  }

  Future<void> addFavorite(FavoriteRestaurant restaurant) async {

    await databaseHelper.insertFavorite(restaurant);

    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {

    await databaseHelper.removeFavorite(id);

    await loadFavorites();
  }
}