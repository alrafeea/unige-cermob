import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/cards/rating_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RatingKeyDialog extends StatefulWidget {
  final okText;
  final String title;
  final Function(RatingModel) okFunction;
  RatingModel selectedValue;

  RatingKeyDialog({
     this.okText = "Confirm",
    @required this.okFunction,
    this.selectedValue, this.title,
  });

  @override
  _RatingKeyDialogState createState() => _RatingKeyDialogState();
}

class _RatingKeyDialogState extends State<RatingKeyDialog> {
  @override
  void initState() {
    super.initState();
    widget.selectedValue =
        widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context);
  }

  showAlertDialog(
    BuildContext context,
  ) {
    // set up the buttons

    Widget confirmButton = FlatButton(
        textColor: AppColors.primaryColor,
        child: Text(this.widget.okText),
        onPressed: () {
          this.widget.okFunction(widget.selectedValue);
          Navigator.of(context).pop();
        });
    Widget cancelButton = FlatButton(
        textColor: AppColors.primaryColor,
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        });
// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,

      title: Text(widget.title, style: TextStyle(fontSize: 14,color: AppColors.primaryColor ),),
      content: createDialogList(),
      actions: [
        confirmButton,
        cancelButton,

      ],
    );
    return alert;
  }

  Widget createDialogList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: Text(
                    "Any",
                    style: Styles.ratingTextStyle(color:  widget.selectedValue == null?AppColors.primaryColor:AppColors.grey,),
                  ),
                ),
              )

            ],
          ),
          SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.MostlyTrue.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.MostlyTrue,
                    iconSize: 23,
                    isActive: widget.selectedValue != null && RatingKey.MostlyTrue.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),
          SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.True.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.True,
                    iconSize: 23,
                    isActive:widget.selectedValue != null && RatingKey.True.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),          SpaceH8(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.MostlyFalse.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.MostlyFalse,
                    iconSize: 23,
                    isActive:widget.selectedValue != null && RatingKey.MostlyFalse.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),          SpaceH8(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.False.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.False,
                    iconSize: 23,
                    isActive:widget.selectedValue != null && RatingKey.False.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.MixMix.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.MixMix,
                    iconSize: 23,
                    isActive: widget.selectedValue != null &&RatingKey.MixMix.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.Outdated.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.Outdated,
                    iconSize: 23,
                    isActive:widget.selectedValue != null && RatingKey.Outdated.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.Scam.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.Scam,
                    iconSize: 23,
                    isActive: widget.selectedValue != null &&RatingKey.Scam.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
              
            ],
          ),SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.Miscaptioned.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.Miscaptioned,
                    iconSize: 23,
                    isActive:widget.selectedValue != null && RatingKey.Miscaptioned.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )
            ],
          ),SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.Rumour.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: Center(
                    child: RatingItem(
                      ratingKey: RatingKey.Rumour,
                      iconSize: 23,
                      isActive: widget.selectedValue != null &&RatingKey.Rumour.getRatingInof().key ==
                          widget.selectedValue.key,
                    ),
                  ),
                ),
              )
              
            ],
          ),SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedValue = RatingKey.Unproven.getRatingInof();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5,left:20),
                  child: RatingItem(
                    ratingKey: RatingKey.Unproven,
                    iconSize: 23,
                    isActive: widget.selectedValue != null &&RatingKey.Unproven.getRatingInof().key ==
                        widget.selectedValue.key,
                  ),
                ),
              )

            ],
          ),SpaceH8(),
        ]),
      ),
    );
  }

  static closeAlertDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
