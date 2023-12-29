import 'package:flutter/material.dart';

class Texts extends StatefulWidget {
  final String text;
  final String variant;
  final Color color;
  final bool bold;
  final bool regular;
  final bool medium;
  final int maxLength;
  final bool italic;
  final TextAlign textAlign;
  final int maxLines;
  final bool readMore;
  final String style;
  final bool allowExpand;
  final double fontSize;

  Texts(this.text,
      {Key key,
      this.variant,
      this.color,
      this.bold,
      this.regular,
      this.medium,
      this.allowExpand = true,
      this.italic: false,
      this.textAlign,
      this.maxLength = 60,
      this.maxLines,
      this.readMore = false,
      this.style,
      this.fontSize})
      : super(key: key);

  @override
  _TextsState createState() => _TextsState();
}

class _TextsState extends State<Texts> {
  bool hidden = false;
  String text = "";

  @override
  void didUpdateWidget(Texts oldWidget) {
    setState(() {
      if (widget.style == "overline")
        text = widget.text.toUpperCase();
      else {
        text = widget.text;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    hidden = widget.readMore;
    if (widget.style == "overline")
      text = widget.text.toUpperCase();
    else {
      text = widget.text;
    }
    super.initState();
  }

  double _getFontSize() {
    switch (widget.variant) {
      case "heading0":
        return 40.0;
      case "heading":
        return 32.0;
      case "heading2":
        return 28.0;
      case "heading3":
        return 18.0;
      case "body1":
        return 18.0;
      case "body2":
        return 20.0;
      case "body2Link":
        return 16.0;
      case "caption":
        return 16.0;
      case "caption2":
        return 14.0;
      case "bodyText":
        return 15.0;
      case "bodyText2":
        return 17.0;
      case "caption3":
        return 12.0;
      case "caption4":
        return 9.0;
      case "overline":
        return 11.0;
      case "date":
        return 24.0;
      default:
        return 16.0;
    }
  }

  FontWeight _getFontWeight() {
    if (widget.bold ?? false) {
      return FontWeight.w900;
    } else if (widget.regular ?? false) {
      return FontWeight.w500;
    } else if (widget.medium ?? false) {
      return FontWeight.w800;
    } else {
      if (widget.style == null) {
        switch (widget.variant) {
          case "heading":
            return FontWeight.w900;
          case "heading2":
            return FontWeight.w900;
          case "heading3":
            return FontWeight.w900;
          case "body1":
            return FontWeight.w800;
          case "body2":
            return FontWeight.w900;
          case "body2Link":
            return FontWeight.w800;
          case "caption":
            return FontWeight.w700;
          case "caption2":
            return FontWeight.w700;
          case "bodyText":
            return FontWeight.w500;
          case "bodyText2":
            return FontWeight.w500;
          case "caption3":
            return FontWeight.w600;
          case "caption4":
            return FontWeight.w600;
          case "overline":
            return FontWeight.w800;
          case "date":
            return FontWeight.w900;
          default:
            return FontWeight.w500;
        }
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _getFontStyle() {
      switch (widget.style) {
        case "headline2":
          return Theme.of(context).textTheme.headline2;
        case "headline3":
          return Theme.of(context).textTheme.headline3;
        case "headline4":
          return Theme.of(context).textTheme.headline4;
        case "headline5":
          return Theme.of(context).textTheme.headline5;
        case "headline6":
          return Theme.of(context).textTheme.headline6;
        case "bodyText2":
          return Theme.of(context).textTheme.bodyText2;
        case "bodyText_15":
          return Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15.0);
        case "bodyText1":
          return Theme.of(context).textTheme.bodyText1;
        case "caption":
          return Theme.of(context).textTheme.caption;
        case "overline":
          return Theme.of(context).textTheme.overline;
        case "button":
          return Theme.of(context).textTheme.button;
        default:
          return TextStyle();
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Text(
                !hidden
                    ? text
                    : (text.substring(
                        0,
                        text.length > widget.maxLength
                            ? widget.maxLength
                            : text.length)),
                textAlign: widget.textAlign,
                overflow: widget.maxLines != null
                    ? ((widget.maxLines > 1)
                        ? TextOverflow.fade
                        : TextOverflow.ellipsis)
                    : null,
                maxLines: widget.maxLines ?? null,
                style: widget.style != null
                    ? _getFontStyle().copyWith(
                        fontStyle: widget.italic ? FontStyle.italic : null,
                        color: widget.color != null ? widget.color : null,
                        fontWeight: _getFontWeight(),
                      )
                    : TextStyle(
                        fontStyle: widget.italic ? FontStyle.italic : null,
                        color:
                            widget.color ?? Colors.black,
                        fontSize: widget.fontSize ?? _getFontSize(),
                        letterSpacing:
                            widget.variant == "overline" ? 1.5 : null,
                        fontWeight: _getFontWeight(),
                      )),
            if (widget.readMore && text.length > widget.maxLength && hidden)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).backgroundColor,
                      Theme.of(context).backgroundColor.withOpacity(0),
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  height: 30,
                ),
              )
          ],
        ),
        if (widget.allowExpand &&
            widget.readMore &&
            text.length > widget.maxLength)
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  hidden = !hidden;
                });
              },
              child: Text(hidden ? "Read More" : "Read less",
                  style: _getFontStyle().copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                      fontFamily: "WorkSans")),
            ),
          ),
      ],
    );
  }
}
