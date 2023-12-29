import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/icon/gradient_Icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final ValueChanged<int> changeIndex;
  final int index;
  final int currentIndex;
  final String name;
  final Function onTap;

  BottomNavigationItem(
      {this.icon,
      this.activeIcon,
      this.changeIndex,
      this.index,
      this.currentIndex,
      this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 70.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onTap !=null?onTap: () => changeIndex(currentIndex),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: currentIndex == index
                      ? GradientIcon(
                          icon: activeIcon,
                          size: 27,
                        )
                      : Icon(icon,
                          color: AppColors.blackShade9, size: 28.0),

                  //GradientIcon(icon: CertifyIcon.path_4,size: 30,)
                ),
                SizedBox(
                  height: 5,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
