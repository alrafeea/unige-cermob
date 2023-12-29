import 'package:flutter/material.dart';

/// [child] A widget that centers its child within itself.
/// [padding] The amount of space by which to inset the child.
/// [color] By default, the color is derived from the [type] of material.
/// [radius] radius value
class CardRoundedWidget extends StatelessWidget {
  final Widget child;
  final double padding;
  final Color color;
  final double radius;

  CardRoundedWidget(
      {@required this.child,
      this.color = Colors.white,
      this.radius = 10.0,
      this.padding = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color,
        child: Stack(
          children: [
            Center(
              child: Container(
                  child: Padding(
                padding: EdgeInsets.all(padding),
                child: Center(child: child),
              )),
            )
          ],
        ),
      ),
    );
  }
}
