import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/cards/user_rating_row.dart';
import 'package:certifyapp/widgets/link_preview/Vertical_Flutter_Link_Preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../pages/adaptive.dart';
import 'expert_rating_row.dart';

class VerticalPostCard extends StatelessWidget {
   VerticalPostCard(
      {this.hasBorder = false,
      this.imageName,
      @required this.child,
      this.onTap,
      Key key,
      this.width,
      this.height,
      this.color,
      this.opacity = 0.4,
      @required this.post,
      this.imageHeight, this.imageWidth})
      : super(key: key);
  final bool hasBorder;
  final String imageName;
  final Widget child;
  final Function onTap;
  double width;
  final double height;
  final double imageHeight;
  final double imageWidth;
  final Color color;
  final double opacity;
  final NewsModel post;

  @override
  Widget build(BuildContext context) {
    width =
        width != null ? width : assignWidth(context: context, fraction: 0.70);
    return post.url == null
        ? Container()
        : InkWell(
            onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(bottom: 8),
        // height: height != nu,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyShade7,
              blurRadius: 8,
              offset: Offset(4, 6),

            ),
          ],
          border: hasBorder
              ? Border.all(width: 1.0, color: const Color(0xffcccccc))
              : Border.all(width: 0.0, color: Colors.transparent),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                  Container(
                    height: assignHeight(context: context, fraction: 0.32),
                    child: VerticalFlutterLinkPreview(
                      post: post,
                      imageHeightFraction: imageHeight,
                      imageWidthFraction: imageWidth,
                      isSourceShow: false,
                      isWebViewScroll: false,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ExpertRatingRow(newsInfo: post,),
                  Divider(
                  ),
                  UserRatingRow(
                    newsInfo: post,
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

