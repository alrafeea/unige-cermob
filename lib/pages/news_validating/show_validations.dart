import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/news_view_model.dart';
import 'package:certifyapp/pages/news_validating/add_validation.dart';
import 'package:certifyapp/pages/news_validating/show_expert_validation.dart';
import 'package:certifyapp/pages/news_validating/show_user_validation.dart';
import 'package:certifyapp/uitl/app_dialogs.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/link_preview/Vertical_Flutter_Link_Preview.dart';
import 'package:certifyapp/widgets/news/Icons/home_icon.dart';
import 'package:certifyapp/widgets/news/Icons/saved_news.dart';
import 'package:certifyapp/widgets/news/Icons/share_post.dart';
import 'package:certifyapp/widgets/others/app_scaffold_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../adaptive.dart';
import '../base/base_view.dart';

// ignore: must_be_immutable
class ShowValidationPage extends StatefulWidget {
  final NewsModel newsInfo;
  final bool isUpdating;

  const ShowValidationPage({Key key, this.newsInfo, this.isUpdating = false})
      : super(key: key);

  @override
  _ShowValidationPageState createState() => _ShowValidationPageState();
}

class _ShowValidationPageState extends State<ShowValidationPage>
    with TickerProviderStateMixin {
  PageController _controller;
  int _currentIndex = 0;
  AuthViewModel authViewModel;

  changePageViewIndex(pageIndex) {
    _currentIndex = pageIndex;
    _controller.jumpToPage(pageIndex);
  }

  bool _isLoading = true;

  @override
  void initState() {
    _controller = new PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of(context, listen: true);
    return BaseView<NewsViewModel>(
      onModelReady: (model) async {
        await model.getNewsUserReviews(widget.newsInfo);
        await model.getNewsExpertReviews(widget.newsInfo);
      },
      builder: (BuildContext context, NewsViewModel model, Widget child) =>
          AppScaffold(
            isShowAppBar: true,
            appBarActions: <Widget>[
              IconButton(
                icon: Icon(CertifyIcon.add_validation),
                color: Color(0xFF313133),
                onPressed: () {
                  if (authViewModel.status == APP_STATUS.UNAUTHENTICATED) {
                    AppDialogs.showAuthDialog(
                        context: context,
                        onSuccess: () {
                          model.getNewsById(widget.newsInfo, authViewModel,
                              onSuccess: (news, isUpdating) {
                                NavigationUtils.appNavigator(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AddValidationPage(
                                            isUpdating: widget.isUpdating,
                                            newsInfo: news,
                                          ),
                                    ),
                                  );
                                });
                              });
                        });
                  } else {


                    NavigationUtils.appNavigator(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddValidationPage(
                                isUpdating: widget.isUpdating,
                                newsInfo: widget.newsInfo,
                              ),
                        ),
                      );
                    });
                  }
                },
              ),
          SharePostIcon(
            post: widget.newsInfo,
          ),
          if (widget.isUpdating) SavedNewsIcon(news: widget.newsInfo),
          HomeIcon(),


            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.PADDING_16, vertical: 0),
              child: SingleChildScrollView(
                child: Container(
                  height: assignHeight(context: context, fraction: 1),
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(

                              height: assignHeight(context: context, fraction: 0.35),
                              child: VerticalFlutterLinkPreview(
                                hasBgColor: false,
                                imageWidthFraction: 0.9,
                                imageHeightFraction:Utils.isSocialMediaLinks(url: widget.newsInfo.url)?0.255: 0.225,
                                titleMaxLines: 2,
                                fontSize: 16,
                                post: widget.newsInfo,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  child: Text(
                                    "Experts Validations",
                                    style: Styles.ratingTextStyle(
                                      fontSize: Sizes.TEXT_SIZE_14,
                                        fontWeight: FontWeight.w600,
                                        color: _currentIndex == 0
                                            ? Color(0xFF464749)
                                            : Color(0xFFAEB0B3),),
                                  ),
                                  onTap: () {
                                    changePageViewIndex(0);
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Text("User Validations",
                                    style: Styles.ratingTextStyle(
                                        fontSize: Sizes.TEXT_SIZE_14,
                                        fontWeight: FontWeight.w600,
                                        color: _currentIndex == 1
                                            ? Color(0xFF464749)
                                            : Color(0xFFAEB0B3),),),
                                onTap: () {
                                  changePageViewIndex(1);
                                },
                              )
                            ],
                          ),
                          SpaceH20(),
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              onPageChanged: (index) {
                                setState(() {
                                  // _currentIndex = index;
                                });
                              },
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                ShowExpertValidation(model: model,),
                                ShowUserValidation(model: model,)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}


