import 'package:certifyapp/core/viewModels/home_view_model.dart';
import 'package:certifyapp/pages/news_validating/show_validations.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/list_builder/horizontal_list_view_builder.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/data_display/cards/vertical_post_Card.dart';
import '../adaptive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController _listViewController;

  int allNewsItemShownCount = 5;
  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    _listViewController = ScrollController();


  }

  @override
  void dispose() {
    _listViewController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of(context);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            // _onStartScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollUpdateNotification) {
            // _onUpdateScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            if (scrollNotification.metrics.pixels ==
                (scrollNotification.metrics.maxScrollExtent)) {
              setState(() {
                isShowMore = true;
              });
              int remainItem = homeViewModel.allNewsList.length -
                  allNewsItemShownCount;
              if (remainItem > 0) {
                setState(() {
                  allNewsItemShownCount += remainItem < 5 ? remainItem : 5;
                });
              } else {
                setState(() {
                  isShowMore = false;
                });
              }
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: homeViewModel.isGettingFeaturedNews ||
              homeViewModel.isGettingAllNews
              ? AppCircularProgressIndicator()
              : Padding(
            padding: const EdgeInsets.only(
                left: Sizes.PADDING_16,
                right: Sizes.PADDING_16,
                top: Sizes.PADDING_22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SpaceH36(),
                Container(
                  margin: EdgeInsets.only(left: Sizes.MARGIN_8),
                  child: Text(
                    "Featured",
                    style: Styles.titleTextStyle(),
                  ),
                ),
                Container(
                  height:
                  assignHeight(context: context, fraction: 0.40),
                  child: ListView.builder(
                      key: ValueKey("featuredNewsList"),
                      itemCount: homeViewModel.featuredNewsList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: Sizes.PADDING_16,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                allNewsItemShownCount =5;
                              });
                              NavigationUtils.appNavigator(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ShowValidationPage(
                                          newsInfo: homeViewModel
                                              .featuredNewsList[i],
                                          isUpdating: true,),
                                  ),
                                );
                              });
                            },
                            child: VerticalPostCard(
                              post: homeViewModel.featuredNewsList[i],
                              imageHeight: 0.235,
                              height: assignHeight(
                                  context: context, fraction: 0.38),
                            ),
                          ),
                        );
                      }),
                ),
                HorizontalListViewBuilder(
                    listViewController: _listViewController,
                    allNewsItemShownCount: allNewsItemShownCount,
                    newsList: homeViewModel.allNewsList,
                    beforeOnTap: (){
                      setState(() {
                        allNewsItemShownCount =5;
                      });
                    },
                    listKey: "allNewsList"),
                if (isShowMore)
                  Container(
                      margin: const EdgeInsets.only(bottom: 150),
                      // color: Colors.black,
                      child: AppCircularProgressIndicator())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

