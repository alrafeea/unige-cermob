import 'dart:ui';

import 'package:certifyapp/config/size_config.dart';
import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/material.dart';

///
class DrawerItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color textColor;
  final Color iconColor;

  DrawerItem(this.title, this.icon,
      {this.textColor = Colors.black,
      this.iconColor = Colors.black87,
      this.subTitle = ''});

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.icon,
            color: widget.iconColor,
            size: SizeConfig.imageSizeMultiplier * 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Texts(
                widget.title,
                color: widget.textColor,
                fontSize: SizeConfig.textMultiplier * 2.3,
              ),
              Texts(
                widget.subTitle,
                color: widget.textColor,
                fontSize: SizeConfig.textMultiplier * 2.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
