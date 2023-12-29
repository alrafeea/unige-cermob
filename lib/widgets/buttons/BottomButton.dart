import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';

/// [label] button label
/// [icon] button icon its optional
/// [color] the background color
/// [textColor] the text color
/// [onTap] button function
/// [loading] show the progress indicator
/// [disabled] disabled the button
/// [borderColor] the button border color
/// [child] the child inside the button
/// [disabledPadding] remove padding
class BottomButton extends StatelessWidget {
  final bool loading;
  final bool disabled;
  final String label;
  final Widget icon;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Function onTap;
  final Widget child;
  final bool disabledPadding;

  BottomButton(
      {Key key,
      this.loading = false,
      this.disabled = false,
      this.label,
      this.icon,
      this.color,
      this.textColor,
      this.disabledPadding = false,
      this.borderColor,
      this.onTap,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  0.0,
                  0.9
                ],
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).backgroundColor.withOpacity(0)
                ]),
          ),
          alignment: Alignment.center,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: child != null
                      ? EdgeInsets.only(
                          left: 14.0, right: 14.0, top: 14.0, bottom: 14)
                      : EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 14.0, bottom: 14),
                  decoration: BoxDecoration(
                      color: child != null
                          ? Theme.of(context).backgroundColor
                          : null,
                      border: child != null
                          ? Border.all(
                              color: Theme.of(context).dividerColor, width: 2.0)
                          : Border.all(color: Colors.transparent, width: 0.0),
                      borderRadius: child != null
                          ? BorderRadius.circular(16.0)
                          : BorderRadius.circular(0.0),
                      boxShadow: child != null
                          ? [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.04),
                                  spreadRadius: -0.0,
                                  offset: Offset(0, 4.0),
                                  blurRadius: 18.0)
                            ]
                          : []),
                  child: Column(
                    children: <Widget>[
                      if (child != null)
                        Padding(
                          padding: disabledPadding
                              ? EdgeInsets.only(
                                  left: 0.0,
                                  right: 0.0,
                                  top: 14.0,
                                  bottom: label != null ? 0.0 : 14)
                              : EdgeInsets.only(
                                  left: 18.0,
                                  right: 18.0,
                                  top: 14.0,
                                  bottom: label != null ? 0.0 : 14),
                          child: child,
                        ),
                      if (child != null)
                        Padding(
                          padding: EdgeInsets.only(top: 14.0, bottom: 14),
                          child: Divider(),
                        ),
                      if (label != null)
                        label == null
                            ? SizedBox(height: 50.0)
                            : Padding(
                                padding: child != null
                                    ? EdgeInsets.only(
                                        bottom: 16.0, left: 16.0, right: 16.0)
                                    : EdgeInsets.zero,
                                child: SecondaryButton(
                                    borderColor: borderColor,
                                    onTap: () {
                                      if (onTap != null) onTap();
                                    },
                                    loading: loading,
                                    disabled: disabled,
                                    label: label,
                                    icon: icon,
                                    color: color,
                                    textColor: textColor),
                              ),
                    ],
                  ),
                ),
                if (label == null && child == null)
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 14.0, bottom: 14),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
