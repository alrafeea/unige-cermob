import 'package:flutter/material.dart';
import 'package:progress_hud_v2/progress_hud.dart';

/// show app Loader
/// [backgroundColor] the background color for the app loader
/// [color] the color for the app loader
class AppLoaderWidget extends StatefulWidget {
  AppLoaderWidget(
      {Key key,
      this.backgroundColor = Colors.black12,
      this.color = Colors.black})
      : super(key: key);

  final Color backgroundColor;
  final Color color;

  @override
  _AppLoaderWidgetState createState() => new _AppLoaderWidgetState();
}

class _AppLoaderWidgetState extends State<AppLoaderWidget> {
  ProgressHUD _progressHUD;

  @override
  void initState() {
    super.initState();

    /// create progress Hud Indicator
    _progressHUD = new ProgressHUD(
      backgroundColor: widget.backgroundColor,
      color: widget.color,
      borderRadius: 5.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(child: _progressHUD);
  }
}
