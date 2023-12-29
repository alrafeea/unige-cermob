import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({
    Key key,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool searchOptionIsOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            if (searchOptionIsOpened)
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(50),
                  border:
                      Border.all(width: 1.0, color: const Color(0xffcccccc)),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Sizes.PADDING_22, horizontal: Sizes.PADDING_16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      SizedBox(height: 60),
                      Row(
                        children: [
                          Icon(
                            CertifyIcon.star_withbg,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: Sizes.MARGIN_10,
                          ),
                          Text("Fact-checkers validation"),
                        ],
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.MARGIN_22,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Any"),
                            SizedBox(
                              width: Sizes.MARGIN_10,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: false,
                                    activeColor: Colors.green,
                                    onChanged: (bool newValue) {
                                      setState(() {});
                                    }),
                                Text('Show only validated results')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            CertifyIcon.person2,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: Sizes.MARGIN_10,
                          ),
                          Text("User validation"),
                        ],
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.MARGIN_22,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Any"),
                            SizedBox(
                              width: Sizes.MARGIN_10,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: false,
                              activeColor: Colors.green,
                              onChanged: (bool newValue) {
                                setState(() {});
                              }),
                          Text('Search only within my posts')
                        ],
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.MARGIN_22,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reset all parameters"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: SecondaryButton(
                                  color: Colors.grey[200],
                                  label: "Cancel",
                                  onTap: () {}),
                                width:assignWidth(context: context, fraction: 0.33)

                            ),
                            Container(

                              child: SecondaryButton(
                                label: "Search",
                                onTap: () {},
                              ),
                              width: assignWidth(context: context, fraction: 0.33),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 0),
              child: TextFields(
                  hintText: "",
                  fontSize: 13.5,
                  onTapTextFields: () {},
                  readOnly: true,
                  // hintColor: Colors.black,
                  suffixIcon: EvaIcons.options2Outline,
                  suffixIconColor: searchOptionIsOpened
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  prefixIcon: CertifyIcon.search,
                  onSuffixTap: () {
                    setState(() {
                      searchOptionIsOpened = !searchOptionIsOpened;
                    });
                  },
                  fontWeight: FontWeight.w600,
                  padding: EdgeInsets.all(Sizes.PADDING_22),

                  // controller: messageController,
                  validator: (value) {
                    if (value == null)
                      return "TranslationBase.of(context";
                    else
                      return null;
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
