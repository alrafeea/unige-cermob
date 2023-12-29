import 'package:flutter/material.dart';

/// FadePage animation
/// [page]
class FadePage extends PageRouteBuilder {
  final Widget page;
  FadePage({this.page})
    : super(
    opaque: false,
    fullscreenDialog: true,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.8),
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) =>
    page,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
      return FadeTransition(
        opacity: animation,
        child: child
      );
    }
  );
}