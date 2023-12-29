import 'package:certifyapp/values/values.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  final Function onTap;

  ArrowBack({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Feedback.wrapForTap(() {
        onTap != null ? onTap() : Navigator.pop(context);
      }, context),
      child: Icon(EvaIcons.arrowIosBackOutline, color:AppColors.iconColor, size: 35,),
    );
  }
}
