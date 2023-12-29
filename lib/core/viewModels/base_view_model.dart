import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  bool isInternetConnection = true;

  ViewState get state => _state;

  String error = "";

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
