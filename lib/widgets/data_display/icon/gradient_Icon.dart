import 'package:certifyapp/config/config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GradientIcon extends StatelessWidget {
  GradientIcon({
    this.icon,
    this.size,
    this.gradient,
  });

  final IconData icon;
  final double size;
  Gradient gradient;

  @override
  Widget build(BuildContext context) {
    if (gradient == null)
      gradient = AppGlobal.linearGradient;
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,

    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
