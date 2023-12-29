import 'package:certifyapp/config/size_config.dart';
import 'package:certifyapp/uitl/translations_delegate_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerUtils {
  int cupertinoPickerIndex = 0;

  /// show Cupertino Picker for any list [context] the page BuildContext
  /// [items] the list of items we need to show
  /// [onSelectFun] the call function on select event
  /// [isDismissible] parameter specifies whether the bottom sheet will be
  /// dismissed when user taps on the scrim.

  ///  [itemExtent] All children will be given the [BoxConstraints] to match this exact
  /// height. Must not be null and must be positive.

  /// The [looping] argument decides whether the child list loops and can be
  /// scrolled infinitely.  If set to true, scrolling past the end of the list
  /// will loop the list back to the beginning.  If set to false, the list will
  /// stop scrolling when you reach the end or the beginning.

  /// [backgroundColor] background color
  showCupertinoPicker(
      {BuildContext context,
      List items,
      String decKey,
      Function onSelectFun,
      bool isDismissible = false,
      double itemExtent = 25,
      bool looping = true,
      Color backgroundColor = const Color(0xfff7f7f7)}) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: SizeConfig.realScreenHeight * 0.4,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text(TranslationBase.of(context).cancel,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoButton(
                      child: Text(
                        TranslationBase.of(context).done,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onSelectFun(cupertinoPickerIndex);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  height: SizeConfig.realScreenHeight * 0.3,
                  color: backgroundColor,
                  child: buildPickerItems(
                      context: context,
                      decKey: decKey,
                      itemExtent: itemExtent,
                      items: items,
                      looping: looping,
                      onSelectFun: onSelectFun))
            ],
          ),
        );
      },
    );
  }

  /// build Cupertino Picker for any list
  /// [context] the page BuildContext
  /// [items] the list of items we need to show
  /// [onSelectFun] the call function on select event
  /// [decKey] the key we show for user
  buildPickerItems(
      {BuildContext context,
      List items,
      String decKey,
      Function onSelectFun,
      double itemExtent,
      bool looping}) {
    return CupertinoPicker(
      magnification: 1.5,
      scrollController:
          FixedExtentScrollController(initialItem: cupertinoPickerIndex),
      children: items.map((item) {
        return Text(
          '${item["$decKey"]}',
          style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
        );
      }).toList(),
      itemExtent: itemExtent,
      looping: looping,
      onSelectedItemChanged: (int index) {
        cupertinoPickerIndex = index;
      },
    );
  }
}
