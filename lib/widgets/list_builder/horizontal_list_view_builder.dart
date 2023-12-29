import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/pages/news_validating/show_validations.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/widgets/data_display/cards/horizantal_post_Card.dart';
import 'package:flutter/material.dart';

class HorizontalListViewBuilder extends StatelessWidget {
  const HorizontalListViewBuilder({
    Key key,
    @required ScrollController listViewController,
    @required this.allNewsItemShownCount,
    @required this.newsList,
    this.listKey, this.beforeOnTap,
  })
      : _listViewController = listViewController,
        super(key: key);

  final ScrollController _listViewController;
  final int allNewsItemShownCount;
  final List<NewsModel> newsList;
  final String listKey;
  final Function beforeOnTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _listViewController,
        key: ValueKey(listKey),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: allNewsItemShownCount>newsList.length?newsList.length:allNewsItemShownCount,
        itemBuilder: (BuildContext context, int index) {
          print(index);
          return InkWell(
            onTap: () {
              if(beforeOnTap!=null) {
                beforeOnTap();
              }
              NavigationUtils.appNavigator(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ShowValidationPage(
                          newsInfo: newsList[index],
                          isUpdating: true,
                        ),
                  ),
                );
              });
            },
            child: HorizontalPostCard(
              post: newsList[index],
              height: assignHeight(context: context, fraction: 0.39),
              imageHeight: 0.235,
              imageWidth: 0.93,
              width: assignWidth(context: context, fraction: 0.9),
            ),
          );
        });
  }
}
