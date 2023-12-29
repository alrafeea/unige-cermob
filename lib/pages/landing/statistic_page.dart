import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/my_validated_news_view_model.dart';
import 'package:certifyapp/core/viewModels/saved_news_view_model.dart';
import 'package:certifyapp/pages/base/base_view.dart';
import 'package:certifyapp/pages/my_account/my_activity_page.dart';
import 'package:certifyapp/pages/my_account/my_saved_page.dart';
import 'package:certifyapp/pages/news_validating/show_validations.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/cards/see_all_data.dart';
import 'package:certifyapp/widgets/data_display/cards/vertical_post_Card.dart';
import 'package:certifyapp/widgets/others/network_base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../adaptive.dart';

class StatisticPage extends StatelessWidget {
  final Function changeCurrentTab;

  const StatisticPage({Key key, this.changeCurrentTab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(
              left: Sizes.PADDING_16,
              right: Sizes.PADDING_16,
              top: Sizes.PADDING_22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SpaceH36(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Sizes.MARGIN_8),
                    child: Text(
                      "My Activities",
                      style: Styles.titleTextStyle(),
                    ),
                  ),
                  SpaceH16(),
                  BaseView<MyValidatedNewsViewModel>(
                      onModelReady: (model) async {
                        if (authViewModel.userData != null)
                          await model.getMyValidatedNews(
                              uid: authViewModel.userData.uid, itemNo: 9);
                      },
                      builder: (BuildContext context,
                              MyValidatedNewsViewModel model, Widget child) =>
                          NetworkBaseView(
                            baseViewModel: model,
                            child: Container(
                              height: assignHeight(
                                  context: context, fraction: 0.40),
                              child: model.validatedNewsList.isEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        left: Sizes.PADDING_16,
                                      ),
                                      child: SeeAllData(
                                        icon:CertifyIcon.add_validation,
                                        msg: "Add Your First Validation",
                                        onTap: () {
                                          changeCurrentTab(0);
                                        },
                                      ),
                                      height: assignHeight(
                                          context: context, fraction: 0.40),
                                    )
                                  : ListView.builder(
                                      key: ValueKey("validatedNewsList"),
                                      itemCount: model.validatedNewsList.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, i) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: Sizes.PADDING_16,
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  NavigationUtils.appNavigator(
                                                      () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ShowValidationPage(
                                                          newsInfo: model
                                                              .validatedNewsList[i],
                                                          isUpdating: true,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: VerticalPostCard(
                                                  post: model
                                                      .validatedNewsList[i],
                                                  imageHeight: 0.235,
                                                  height: assignHeight(
                                                      context: context,
                                                      fraction: 0.38),
                                                ),
                                              ),
                                              if (i ==
                                                  model.validatedNewsList
                                                          .length -
                                                      1)
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    left: Sizes.PADDING_16,
                                                  ),
                                                  child: SeeAllData(

                                                    msg:"See More ...",
                                                    // icon:CertifyIcon.add_validation,

                                                    onTap: (){
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) =>
                                                                  MyActivitiesPage()));
                                                    },
                                                  ),
                                                  height: assignHeight(
                                                      context: context,
                                                      fraction: 0.40),
                                                )
                                            ],
                                          ),
                                        );
                                      }),
                            ),
                          )),
                ],
              ),
              SpaceH36(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Sizes.MARGIN_8),
                    child: Text(
                      "My Saved News",
                      style: Styles.titleTextStyle(),
                    ),
                  ),
                  SpaceH16(),
                  BaseView<SavedNewsViewModel>(
                      onModelReady: (model) async {
                        if (authViewModel.userData != null)
                        await model.getMySavedNews(
                            uid: authViewModel.userData.uid, itemNo: 9);
                      },
                      builder: (BuildContext context,
                          SavedNewsViewModel model, Widget child) =>
                          NetworkBaseView(
                            baseViewModel: model,
                            child: Container(
                              height: assignHeight(
                                  context: context, fraction: 0.40),
                              child: model.savedNewsList.isEmpty
                                  ? Container(
                                margin: const EdgeInsets.only(
                                  left: Sizes.PADDING_16,
                                ),
                                child: SeeAllData(
                                  msg: "Add Your First Saved News",
                                  icon:CertifyIcon.star,
                                  onTap: () {
                                    changeCurrentTab(0);
                                  },
                                ),
                                height: assignHeight(
                                    context: context, fraction: 0.40),
                              )
                                  : ListView.builder(
                                  key: ValueKey("savedNewsList"),
                                  itemCount: model.savedNewsList.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: Sizes.PADDING_16,
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              NavigationUtils.appNavigator(
                                                      () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                            ShowValidationPage(
                                                              newsInfo: model
                                                                  .savedNewsList[i],
                                                              isUpdating: true,
                                                            ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: VerticalPostCard(
                                              post: model
                                                  .savedNewsList[i],
                                              imageHeight: 0.235,
                                              height: assignHeight(
                                                  context: context,
                                                  fraction: 0.38),
                                            ),
                                          ),
                                          if (i ==
                                              model.savedNewsList
                                                  .length -
                                                  1)
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: Sizes.PADDING_16,
                                              ),
                                              child: SeeAllData(
                                                msg:"See More ...",
                                                // icon:CertifyIcon.star,
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext context) =>
                                                              MySavedPage()));
                                                },
                                              ),
                                              height: assignHeight(
                                                  context: context,
                                                  fraction: 0.40),
                                            )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          )),
                ],
              ),
              SpaceH36(),
              SpaceH36(),
              SpaceH36(),
            ],
          )),
    ));
  }
}

