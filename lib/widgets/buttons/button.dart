import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/// Button widget
/// [label] button label
/// [icon] button icon its optional
/// [onTap] button function
/// [loading] show the progress indicator
/// [elevation] color elevation value
class Button extends StatefulWidget {
  Button(
      {Key key,
      this.label: "",
      this.icon,
      this.onTap,
      this.loading: false,
      this.elevation: true})
      : super(key: key);

  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final bool loading;
  final bool elevation;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  double _buttonSize = 1.0;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.7,
        upperBound: 1.0,
        duration: Duration(milliseconds: 120));
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
          margin: EdgeInsets.only(right: 12.0),
          height: 24.0,
          child: widget.icon);
    } else if (widget.icon != null) {
      return Container(
        height: 18.0,
        width: 18.0,
        child: widget.icon,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
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
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            margin:
                EdgeInsets.only(bottom: widget.label.isNotEmpty ? 14.0 : 0.0),
            padding: EdgeInsets.symmetric(
                vertical: widget.label != null && widget.label.isNotEmpty
                    ? 12.0
                    : 15.0,
                horizontal: widget.label != null && widget.label.isNotEmpty
                    ? 22.0
                    : 19),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color:  HexColor('#515b5d'),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(
                          120, 71, 80, widget.elevation ? 0.28 : 0.0),
                      spreadRadius:
                          _buttonSize < 1.0 ? -(1 - _buttonSize) * 50 : 0.0,
                      offset: Offset(0, 7.0),
                      blurRadius: 24.0)
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildIcon(),
                widget.loading
                    ? Padding(
                        padding: const EdgeInsets.all(2.7),
                        child: SizedBox(
                          height: 19.0,
                          width: 19.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey[300],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 3.0),
                        child: Text(widget.label,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: "WorkSans")),
                      )
              ],
            ),
          )),
    ));
  }
}
