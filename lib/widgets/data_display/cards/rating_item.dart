import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RatingItem extends StatelessWidget {
  RatingItem({
    Key key,
    this.ratingKey,
    this.iconSize = 40,
    this.isSmall = false,
    this.isActive = false
  }) : super(key: key);
  final RatingKey ratingKey;
  double iconSize;
  final bool isSmall;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    if (isSmall) {
      isActive = true;
      iconSize =20;
    }
    RatingModel ratingIno = ratingKey.getRatingInof();
    return InkWell(
      child: Row(
        children: [
          Icon(
            ratingIno.icon,
            size: iconSize,
            color: isActive ? ratingIno.activeColor : ratingIno.disabledColor,
          ),
          SizedBox(
            width: Sizes.MARGIN_10,
          ),
          if(!isSmall)
          Text(
            ratingIno.label,
            style: Styles.ratingTextStyle(color: isActive?Color(0xFF464749):AppColors.grey),
          ),
        ],
      ),
    );
  }
}
