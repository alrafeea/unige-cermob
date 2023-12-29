// ignore: must_be_immutable
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewSource extends StatelessWidget {
  ViewSource({
    Key key,
    @required this.url,
  }) : super(key: key);

  String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String url = this.url;
        await launch(url);
      },
      child: Text(
        "Source",
        style: Styles.ratingTextStyle(
          fontSize: Sizes.TEXT_SIZE_12,
          color: Color(0xFF00A1ED),
        ).copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
