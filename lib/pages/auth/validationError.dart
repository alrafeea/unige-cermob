import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/material.dart';

class validationError extends StatelessWidget {
  const validationError({
    Key key,
    @required this.userErrorMsg,
  }) : super(key: key);

  final String userErrorMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .77,
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Texts("$userErrorMsg", color: Color.fromRGBO(235, 80, 60, 1.0), variant: "caption2"),
    );
  }
}
