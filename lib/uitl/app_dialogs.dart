import 'package:certifyapp/config/config.dart';
import 'package:certifyapp/pages/auth/auth_start_page.dart';
import 'package:flutter/material.dart';

class AppDialogs {


  static showAuthDialog(
      {BuildContext context,
      String url,
      Function onSuccess,
      Function onError}) {
    showDialog(
        context: context == null ? AppGlobal.context : context,
        builder: (_) => Center(
          child: Container(
            width: MediaQuery.of(context).size.width *0.9,
            height: MediaQuery.of(context).size.height * 0.9,

            child: AuthStartPage(
                  onSuccess: onSuccess,
                ),

          ),
        ));
  }
}
