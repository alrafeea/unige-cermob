import 'package:certifyapp/uitl/time_extension.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';

class TimeAgo extends StatelessWidget {
  const TimeAgo({
    Key key,
    @required this.createdAt,
  }) : super(key: key);

  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    String date = createdAt!=null?createdAt.toString():
    DateTime.now().toString();
    return Text(
      DisplayTimeAgoFromExtension
          .displayTimeAgoFromTimestamp(date
          ),
      style: TextStyle(
          fontSize: Sizes.TEXT_SIZE_10,
          color: AppColors.blackShade7),
    );
  }
}