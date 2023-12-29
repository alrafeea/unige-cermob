import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// LargeAvatar
/// [name] the user name
/// [url] the image url
/// [disableProfileView] disable user profile view
/// [radius] the avatar radius
/// [width] the avatar width
/// [height] the avatar height
/// [onTap] on tap function
class LargeAvatar extends StatelessWidget {
  LargeAvatar(
      {Key key,
      @required this.name,
      this.url,
      this.disableProfileView: false,
      this.radius = 60.0,
      this.width = 90,
      this.height = 90,
      this.onTap})
      : super(key: key);

  final String name;
  final String url;
  final bool disableProfileView;
  final double radius;
  final double width;
  final double height;
  final GestureTapCallback onTap;

  Widget _getAvatar() {
    if (url != null && url.isNotEmpty && Uri.parse(url).isAbsolute) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: Image.network(
            url.trim(),
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
      );
    } else
      return Center(
          child: Texts(
        name[0].toUpperCase(),
        color: Colors.white,
        fontSize: 18,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disableProfileView ? null : onTap,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(-1, -1),
                end: Alignment(1, 1),
                colors: [
                  Colors.grey[100],
                  Colors.grey[800],
                ]),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 16.0)
            ],
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          width: width,
          height: height,
          child: _getAvatar()),
    );
  }
}
