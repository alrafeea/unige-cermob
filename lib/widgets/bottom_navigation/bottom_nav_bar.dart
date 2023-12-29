import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/uitl/translations_delegate_base.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/curved_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_item.dart';

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> changeIndex;
  final int currentTab ;
  BottomNavBar({Key key, this.changeIndex, this.currentTab =0}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;
  @override
  void initState() {
    super.initState();

  }
  _changeIndex(int index) {
    widget.changeIndex(index);
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _index = widget.currentTab??0;

    return CurvedContainer(
      topLeftRadius: 30,
      topRightRadius: 30,
      // bottomLeftRadius: 8,
      // bottomRightRadius: 8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.RADIUS_40), topRight: Radius.circular(Sizes.RADIUS_40)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackShade8,
            blurRadius: 12,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      height: assignHeight(context: context, fraction: 0.08),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationItem(
              icon: CertifyIcon.unfilled_home,
              activeIcon: CertifyIcon.home,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 0,
            ),
            BottomNavigationItem(
              icon: CertifyIcon.search,
              activeIcon: CertifyIcon.search,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 1,
              name: TranslationBase.of(context).replay2,
            ),
            BottomNavigationItem(
              icon:CertifyIcon.add_not_filled,
              activeIcon: CertifyIcon.filled_add,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 2,
            ),
            BottomNavigationItem(
              icon:CertifyIcon.trend,
              activeIcon: CertifyIcon.trend_filled,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 3,
            ),
            BottomNavigationItem(
              icon: CertifyIcon.account_not_filled,
              activeIcon: CertifyIcon.filled_person,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 4,
              name: TranslationBase.of(context).services,
            )
          ],
        ),
      ),
    );
  }
}
