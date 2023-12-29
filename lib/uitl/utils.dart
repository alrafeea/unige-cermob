import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_shared_preferences.dart';
import 'app_toast.dart';

AppSharedPreferences sharedPref = new AppSharedPreferences();

class Utils {
  ///show  custom Error Toast
  ///  [message] to show for user
  static showErrorToast([String message]) {
    String localMsg = generateContactAdminMessage();
    if (message != null) {
      localMsg = message.toString();
    }
    AppToast.showErrorToast(message: localMsg,backgroundColor: Colors.white,
      textColor: Colors.red[400],
      radius: 50,
      fontSize: 13,);
  }

  static showSuccessCustomAppToast({String msg = "Success"}) {
    AppToast.showSuccessToast(
        message: msg,
        backgroundColor: Colors.white,
        textColor: Color(0xFF9E1F63),
        fontSize: 13,
        radius: 50);
  }

  // /// Check The Internet Connection
  // static Future<bool> checkConnection() async {
  //   ConnectivityResult connectivityResult =
  //       await (Connectivity().checkConnectivity());
  //   if ((connectivityResult == ConnectivityResult.mobile) ||
  //       (connectivityResult == ConnectivityResult.wifi)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  /// generate Contact Admin Message
  static generateContactAdminMessage([err]) {
    String localMsg = 'Something wrong happened, please contact the admin';
    if (err != null) {
      localMsg = localMsg + '\n \n' + err.toString();
    }
    return localMsg;
  }

  /// hides the keyboard if its already open
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static String encryptStringByAES({@required String string}) {
    var key = encrypt.Key.fromBase64(
        'yE9tgqNxWcYDTSPNM+EGQw=='); // obviously, insert your own value!
    var iv = encrypt.IV.fromBase64('8PzGKSMLuqSm0MVbviaWHA==');
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(string, iv: iv);
    return encrypted.base64.replaceAll('/', '');
  }

  static String getUrlWithOutQueryParams({@required String url}) {
    if (url.indexOf('?') > -1) {
      return url.substring(0, url.indexOf('?'));
    }

    return url;
  }

  static bool isSocialMediaLinks({@required String url}) {
    if (url.indexOf('facebook') > -1 || url.indexOf('twitter') > -1) {
      return true;
    }

    return false;
  }

  static changeBottomBarSysStyle({BuildContext context, w}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: Theme.of(context).brightness));
  }

  static openTermPage() async {
    await launch('https://www.certify.community/terms');
  }

  static openPrivacyPage() async {
    await launch('https://www.certify.community/privacy');
  }

  static openAboutUsPage() async {
    await launch('https://certify.community');
  }
}
