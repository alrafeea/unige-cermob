import 'package:certifyapp/widgets/Buttons/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonActions extends StatelessWidget {
  final VoidCallback onPositive;

  const ButtonActions({
    Key key,
    @required this.onPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Button(
          onTap: onPositive,
          label: "Confirm",
        ),
      ),
    );
  }
}
