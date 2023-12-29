import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

/// Custom Item widget
/// [startIcon] icon at the start of the widget
/// [startIconSize] icon size of start icon
/// [startIconColor] icon color of start icon
/// [endIcon] icon at the end of the widget
/// [endIconSize] icon size of end icon
/// [endIconColor] icon color of end icon
/// [disabled] disabled on tap function
/// [onTap] opTap function
/// [padding] padding of the widget
/// [child] child of the widget
/// [decoration] decoration of the widget
class CustomItem extends StatelessWidget {
  final IconData startIcon;
  final double startIconSize;
  final Color startIconColor;
  final IconData endIcon;
  final double endIconSize;
  final Color endIconColor;
  final bool disabled;
  final Function onTap;
  final EdgeInsets padding;
  final Widget child;
  final BoxDecoration decoration;

  CustomItem(
      {Key key,
      this.startIcon,
      this.disabled: false,
      this.onTap,
      this.startIconColor,
      this.endIcon = EvaIcons.chevronRight,
      this.padding,
      this.child,
      this.endIconColor,
      this.endIconSize = 20,
      this.decoration,
      this.startIconSize = 19})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Container(
        decoration: decoration != null ? decoration : BoxDecoration(),
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Padding(
            padding: padding != null
                ? padding
                : const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              children: <Widget>[
                if (startIcon != null)
                  Expanded(
                    flex: 1,
                    child: Icon(
                      startIcon,
                      color: startIconColor ?? Theme.of(context).primaryColor,
                      size: startIconSize,
                    ),
                  ),
                if (startIcon != null) SizedBox(width: 18.0),
                Expanded(
                  child: child,
                  flex: 10,
                ),
                endIcon == null
                    ? Expanded(child: Container())
                    : Expanded(
                        flex: 1,
                        child: Icon(
                          endIcon,
                          color: endIconColor != null
                              ? endIconColor
                              : Colors.grey[500],
                          size: endIconSize,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
