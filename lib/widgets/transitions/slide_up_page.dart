import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///Slide Up Page Route
/// [widget] widget we need to slide up
/// [fullscreenDialog] show the widget as full screen dialog
/// [opaque] When an opaque route's entrance transition is complete, the routes behind the opaque route will not be built to save resources.
class SlideUpPageRoute extends PageRouteBuilder {
  final Widget widget;
  final bool fullscreenDialog;
  final bool opaque;

  SlideUpPageRoute(
      {this.widget, this.fullscreenDialog = false, this.opaque = true})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          fullscreenDialog: fullscreenDialog,
          opaque: opaque,
          barrierColor: Color.fromRGBO(0, 0, 0, 0.5),
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 800),
          transitionsBuilder: ((BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.easeInOutQuint;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
                position: animation.drive(tween), child: child);
          }),
        );
}
