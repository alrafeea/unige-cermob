import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text.dart';

// ignore: must_be_immutable
class SelectGenderDialog extends StatefulWidget {
  final Function(String) onValueSelected;
  String selectedGender;

  SelectGenderDialog(
      {Key key, /*this.relationTypes,*/ this.onValueSelected, this.selectedGender});

  @override
  _SelectGenderDialogState createState() => _SelectGenderDialogState();
}

class _SelectGenderDialogState extends State<SelectGenderDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return SimpleDialog(
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.selectedGender = "Female";
                              });
                            },
                            child: ListTile(
                              title: Text("Female"),
                              leading: Radio(
                                value: "Female",
                                groupValue: widget.selectedGender,
                                activeColor: Colors.red[800],
                                onChanged: (value) {
                                  setState(() {
                                    widget.selectedGender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.selectedGender = "Male";
                              });
                            },
                            child: ListTile(
                              title: Text("Male"),
                              leading: Radio(
                                value: "Male",
                                groupValue: widget.selectedGender,
                                activeColor: Colors.red[800],
                                onChanged: (value) {
                                  setState(() {
                                    widget.selectedGender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ),

            SizedBox(
              height: 5.0,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Texts(
                            "Cancel",
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey[500],
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      widget.onValueSelected(widget.selectedGender);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Texts(
                            "OK",
                      )),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
