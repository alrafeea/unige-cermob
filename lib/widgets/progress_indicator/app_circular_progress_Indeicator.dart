import 'package:flutter/material.dart';

/// Show Progress Indicator
class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: const CircularProgressIndicator()),
    );
  }
}
