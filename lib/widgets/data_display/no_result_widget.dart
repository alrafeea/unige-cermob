import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';

class NoResultMsg extends StatelessWidget {
  const NoResultMsg({
    Key key, this.msg = "No Validations For This News ",
  }) : super(key: key);
  final msg;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/images/no-result.png', height: 159,),
          SizedBox(height: 20,),
          Text(msg,
              textAlign: TextAlign.center,
              style: Styles.ratingTextStyle(
                  fontWeight: FontWeight.w600, fontSize: Sizes.TEXT_SIZE_18)),
        ],
      ),
    );
  }
}
