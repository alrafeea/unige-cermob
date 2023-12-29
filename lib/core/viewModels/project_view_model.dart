  import 'dart:async';

import 'package:certifyapp/uitl/app_shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class ProjectViewModel with ChangeNotifier {
  AppSharedPreferences sharedPref = AppSharedPreferences();
  Locale _appLocale;
  String currentLanguage = 'en';
  bool _isArabic = false;
  bool isInternetConnection = true;
  bool isLoading = false;
  bool isError = false;
  String error = '';

  Locale get appLocal => _appLocale;

  bool get isArabic => _isArabic;
  StreamSubscription subscription;

  ProjectViewModel() {
    // loadSharedPrefLanguage();

    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   switch (result) {
    //     case ConnectivityResult.wifi:
    //       isInternetConnection = true;
    //       break;
    //     case ConnectivityResult.mobile:
    //       isInternetConnection = true;
    //       break;
    //     case ConnectivityResult.none:
    //       isInternetConnection = false;
    //       break;
    //   }
    //   notifyListeners();
    // });
  }

  // void loadSharedPrefLanguage() async {
  //   currentLanguage = await sharedPref.getString(APP_LANGUAGE);
  //   _appLocale = Locale(currentLanguage ?? 'en');
  //   _isArabic = currentLanguage != null
  //       ? currentLanguage == 'ar' ? true : false
  //       : false;
  //   notifyListeners();
  // }
  //
  // void changeLanguage(String lan) {
  //   if (lan != "en" && currentLanguage != lan) {
  //     _appLocale = Locale("ar");
  //     _isArabic = true;
  //     currentLanguage = 'ar';
  //     sharedPref.setString(APP_LANGUAGE, 'ar');
  //   } else if (lan != "ar" && currentLanguage != lan) {
  //     _appLocale = Locale("en");
  //     _isArabic = false;
  //     currentLanguage = 'en';
  //     sharedPref.setString(APP_LANGUAGE, 'en');
  //   }
  //
  //   notifyListeners();
  // }

  @override
  void dispose() {
    if (subscription != null) subscription.cancel();
    super.dispose();
  }
}
