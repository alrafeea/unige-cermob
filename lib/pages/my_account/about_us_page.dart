import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/saved_news_view_model.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/no_result_widget.dart';
import 'package:certifyapp/widgets/list_builder/horizontal_list_view_builder.dart';
import 'package:certifyapp/widgets/others/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../adaptive.dart';
import '../base/base_view.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel =Provider.of<AuthViewModel>(context);

    ThemeData theme = Theme.of(context);
    double heightOfAppBar = assignHeight(context: context, fraction: 0.11);
    return AppScaffold(
      isShowAppBar: true,
      appBarTitle: "About Certify",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_16),
          child: Column(
            children: [
              Container(
                height: assignHeight(context: context, fraction: 1),
                child:RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Certify is an innovative tool from the University of Geneva (Switzerland) to fight fake news online. It enables users and experts to validate the news they read on social media and the web. Furthermore, certify is fun to use. Users can share any post to Certify to validate it or view fact-checking information about it from experts and other users. Users can also go directly to the app, browse validated news, and share news from there with its validation information for any post as a trusted news source.Certify can be used as a standalone trusted social media where news is gathered from different sources and validated by specialized experts in different fields and the end-users as they are an essential part of the process.For more information, please visit : ',
                            style: TextStyle()),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () async {
                            await Utils.openAboutUsPage();
                          },
                          text: 'https://certify.community',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
