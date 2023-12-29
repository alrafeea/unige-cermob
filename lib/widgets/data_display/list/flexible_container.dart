import 'package:flutter/material.dart';
/// Flexible container widget
/// [widthFactor] If non-null, the fraction of the incoming width given to the child.
/// If non-null, the child is given a tight width constraint that is the max
/// incoming width constraint multiplied by this factor.
/// If null, the incoming width constraints are passed to the child

/// [heightFactor]If non-null, the fraction of the incoming height given to the child.
/// If non-null, the child is given a tight height constraint that is the max
/// incoming height constraint multiplied by this factor.
/// If null, the incoming height constraints are passed to the child
/// [padding] add padding to the container
/// [child] child widget inside the container
class FlexibleContainer extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;
  final EdgeInsets padding;
  final Widget child;

  FlexibleContainer({
    Key key,
    this.widthFactor = 0.9,
    this.heightFactor = 1,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Container(
            padding: padding,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
            child: child,
          ),
        ),
      ),
    );
  }
}
