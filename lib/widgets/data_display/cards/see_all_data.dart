import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';

class SeeAllData extends StatelessWidget {
  const SeeAllData({
    Key key, this.onTap, this.msg, this.icon,
  }) : super(key: key);

  final Function onTap;
  final String msg;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            bottom: 8),
        // height: height != nu,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(
              20),
          boxShadow: [
            BoxShadow(
              color: AppColors
                  .greyShade7,
              blurRadius: 8,
              offset: Offset(4, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon!=null)
            Icon(icon, color: AppColors.primaryColor,size: 100,),
            if(icon!=null)
            SizedBox(height: 20,),
            Text('$msg', style: Styles.titleTextStyle(fontSize:Sizes.TEXT_SIZE_18 ),),
          ],
        ),
        width: assignWidth(context: context, fraction: 0.7),
      ),
    );
  }
}
