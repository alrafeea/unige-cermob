import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/material.dart';

enum MINI_BUTTON { Secondary, Primary }

/// Button widget
/// [label] button label
/// [icon] button icon its optional
/// [onTap] button function
/// [variant] determine the color button
class MiniButton extends StatefulWidget {
  MiniButton(
      {
      this.label: "",
      this.icon,
      this.onTap,
      this.variant: MINI_BUTTON.Secondary});


  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final MINI_BUTTON variant;

  @override
  _MiniButtonState createState() => _MiniButtonState();
}

class _MiniButtonState extends State<MiniButton> with TickerProviderStateMixin {
  double _buttonSize = 1.0;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.7,
      upperBound: 1.0,
      duration: Duration(milliseconds: 120),
    );
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuad,
        reverseCurve: Curves.easeOutQuad);
    _animation.addListener(() {
      setState(() {
        _buttonSize = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildIcon() {
    if (widget.icon != null && (widget.label != null && widget.label != "")) {
      return Container(
          margin: EdgeInsets.only(right: 8.0),
          child: Icon(
            widget.icon,
            size: 18.0,
            color: widget.variant == MINI_BUTTON.Primary
                ? Colors.white
                : Color.fromRGBO(78, 62, 253, 1.0),
          ));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails tap) {
        _animationController.reverse(from: 1.0);
      },
      onTapUp: (TapUpDetails tap) {
        _animationController.forward();
      },
      onTapCancel: () {
        _animationController.forward();
      },
      onTap: Feedback.wrapForTap(widget.onTap, context),
      behavior: HitTestBehavior.opaque,
      child: Transform.scale(
        scale: _buttonSize,
        child: Container(
          margin: EdgeInsets.only(top: 18.0, bottom: 24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
            color: widget.variant == MINI_BUTTON.Primary
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.13),
          ),
          padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildIcon(),
              Padding(
                padding: EdgeInsets.only(bottom: 1.5),
                child: Texts(widget.label,
                    color: widget.variant == MINI_BUTTON.Primary
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    style: "bodyText1",
                    bold: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
