import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {

  int _count = 0;

  int get count => _count;

  void increment() {

    _count++;

    notifyListeners();

  }

}