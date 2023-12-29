import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/saved_news_view_model.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/no_result_widget.dart';
import 'package:certifyapp/widgets/list_builder/horizontal_list_view_builder.dart';
import 'package:certifyapp/widgets/others/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../adaptive.dart';
import '../base/base_view.dart';

class MySavedPage extends StatefulWidget {
  @override
  _MySavedPageState createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel =Provider.of<AuthViewModel>(context);

    ThemeData theme = Theme.of(context);
    double heightOfAppBar = assignHeight(context: context, fraction: 0.11);
    return BaseView<SavedNewsViewModel>(
      onModelReady: (model) async {
        await model.getMySavedNews(uid: authViewModel.userData.uid);
      },
      builder: (BuildContext context, SavedNewsViewModel model, Widget child) =>
          AppScaffold(
        isShowAppBar: true,
        appBarTitle: "My News",
        baseViewModel: model,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_16),
            child: Column(
              children: [
                Container(
                  height: assignHeight(context: context, fraction: 1),
                  child: model.savedNewsList.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: 200, left: 30),
                          child: NoResultMsg(
                            msg: "No Result Found",
                          ))
                      : Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: HorizontalListViewBuilder(
                                allNewsItemShownCount: model.savedNewsList.length,
                                newsList:  model.savedNewsList,
                                listKey: "savedNewsList"),
                          ),

                          SpaceH30(),
                          SpaceH30(),
                          SpaceH30(),

                        ],
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
