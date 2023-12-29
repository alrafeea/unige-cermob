import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/saved_news_view_model.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/no_result_widget.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:certifyapp/widgets/list_builder/horizontal_list_view_builder.dart';
import 'package:certifyapp/widgets/others/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../adaptive.dart';
import '../base/base_view.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isShowAppBar: true,
      appBarTitle: "Contact Us",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_16),
          child: Column(
            children: [
              Container(
                child: RichText(
                    text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            "We're always excited to hear from you! If you have any feedback, questions, or concerns, please email us on ",
                        style: TextStyle()),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launch('admin@certify.community');
                        },
                      text: 'admin@certify.community',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                        text: " or through this form.", style: TextStyle()),
                  ],
                )),
              ),
              SpaceH44(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: Styles.ratingTextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Sizes.TEXT_SIZE_18,
                        color: Color(0xFF313133),
                      ),
                    ),
                    SpaceH4(),
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 2, top: 0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyShade7,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: TextFields(
                          textFormFieldColor: AppColors.TextFieldsColor,
                          textFormFieldRadius: 12,
                          hintText: "Add Your Full Name",
                          minLines: 1,
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                          padding: EdgeInsets.all(Sizes.PADDING_22),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null ||
                                value == '' ||
                                !Uri.parse(value).isAbsolute)
                              return "Please add Claim";
                            else
                              return null;
                          }),
                    ),
                    SpaceH24(),
                    Text(
                      "Email",
                      style: Styles.ratingTextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Sizes.TEXT_SIZE_18,
                        color: Color(0xFF313133),
                      ),
                    ),
                    SpaceH4(),
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 2, top: 0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyShade7,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: TextFields(
                          textFormFieldColor: AppColors.TextFieldsColor,
                          textFormFieldRadius: 12,
                          hintText: "Add Email",
                          minLines: 1,
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                          padding: EdgeInsets.all(Sizes.PADDING_22),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null ||
                                value == '' ||
                                !Uri.parse(value).isAbsolute)
                              return "Please add Email";
                            else
                              return null;
                          }),
                    ),
                    SpaceH24(),
                    Text(
                      "Subject",
                      style: Styles.ratingTextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Sizes.TEXT_SIZE_18,
                        color: Color(0xFF313133),
                      ),
                    ),
                    SpaceH4(),
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 2, top: 0),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.RADIUS_40), topRight: Radius.circular(Sizes.RADIUS_40)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyShade7,
                            blurRadius: 8,
                            // offset: Offset(1, 1), // Shadow position
                          ),
                        ],
                      ),
                      child: TextFields(
                          textFormFieldColor: AppColors.TextFieldsColor,
                          textFormFieldRadius: 12,
                          hintText: "Add Subject",
                          minLines: 1,
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                          padding: EdgeInsets.all(Sizes.PADDING_22),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null ||
                                value == '' ||
                                !Uri.parse(value).isAbsolute)
                              return "Please add Subject";
                            else
                              return null;
                          }),
                    ),

                    SpaceH24(),
                    Text(
                      "Message",
                      style: Styles.ratingTextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Sizes.TEXT_SIZE_18,
                        color: Color(0xFF313133),
                      ),
                    ),
                    SpaceH4(),
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 2, top: 0),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.RADIUS_40), topRight: Radius.circular(Sizes.RADIUS_40)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyShade7,
                            blurRadius: 8,
                            // offset: Offset(1, 1), // Shadow position
                          ),
                        ],
                      ),
                      child: TextFields(
                          textFormFieldColor: AppColors.TextFieldsColor,
                          textFormFieldRadius: 12,
                          hintText: "Add Message",
                          minLines: 5,
                          maxLines: 30,
                          fontWeight: FontWeight.w600,
                          padding: EdgeInsets.all(Sizes.PADDING_22),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null ||
                                value == '' ||
                                !Uri.parse(value).isAbsolute)
                              return "Please add Claim";
                            else
                              return null;
                          }),
                    ),
                    SpaceH48(),
                    SpaceH12(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          border: Border.all(color: HexColor('#707070'), width: 0),
        ),
        // color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        child: ListView(
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: SecondaryButton(
                        label: "Submit", fontSize: 17, onTap: () async {}
                        // },
                        ),
                    width: assignWidth(context: context, fraction: 0.70),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
