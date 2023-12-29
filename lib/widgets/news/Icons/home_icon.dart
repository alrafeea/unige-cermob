import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/pages/landing/landing_page.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(CertifyIcon.unfilled_home),
      color: AppColors.iconColor,
      onPressed: () {
        NavigationUtils.appNavigator(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LandingPage(url: null,preventListeningToSharing: true,),
              ),
                  (Route<dynamic> r) => false);
        },);
      },);
  }
}