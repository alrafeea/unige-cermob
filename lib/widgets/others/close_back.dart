import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CloseBack extends StatelessWidget{

  final Function onTap;

  CloseBack({Key key,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Feedback.wrapForTap(() {
        onTap!=null ? onTap() : Navigator.pop(context);
      }, context),
      child: Icon(EvaIcons.close, color: Color.fromRGBO(78, 62, 253, 1.0)),
    );
  }
}