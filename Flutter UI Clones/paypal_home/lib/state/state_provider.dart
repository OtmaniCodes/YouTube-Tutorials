import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier {
  int _screenIndex = 0;

  int get getScreenIndex => _screenIndex;
  set setScreenIndex(int val) {
    _screenIndex = val;
    notifyListeners();
  }
}
