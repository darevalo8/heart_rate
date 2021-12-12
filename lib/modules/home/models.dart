import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  double? _currentPage;

  double get currentPage => this._currentPage ?? 0;

  set currentPage(double page) {
    this._currentPage = page;
    notifyListeners();
  }
}
