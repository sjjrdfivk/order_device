import 'package:flutter/material.dart';

class OrderStore extends ChangeNotifier {
  double scrollVal = 0;

  void setScrollvalue(double value) {
    scrollVal = value;
    notifyListeners();
  }

  double get getScrollValue => scrollVal;
}
