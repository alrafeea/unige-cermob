import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/cards/user_rating_row.dart';
import 'package:certifyapp/widgets/link_preview/Vertical_Flutter_Link_Preview.dart';
import 'package:certifyapp/widgets/news/Icons/saved_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../pages/adaptive.dart';
import '../../news/Icons/share_post.dart';
import 'expert_rating_row.dart';

// ignore: must_be_immutable
class HorizontalPostCard extends StatelessWidget {
   HorizontalPostCard(
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
  AuthViewModel authViewModel;


  @override
  Widget build(BuildContext context) {
    return post.url == null?Container():InkWell(
      onTap: onTap,
      child: Container(
        width: width != null
            ? width
            : assignWidth(context: context, fraction: 0.92),
        // height: height != nu,
        margin: EdgeInsets.only(bottom: Sizes.MARGIN_16 ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.greyShade7,
              blurRadius: 8,
              offset: Offset(4, 8),

            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
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
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if(post.counters.expertsValidations!=0)
                  ExpertRatingRow(newsInfo: post,),
                  if(post.counters.usersValidations!=0)
                  UserRatingRow(newsInfo: post,),
                  Divider(
                  )
,
                  Container(
                    child: Row(

                      children: [
                              SharePostIcon(
                                post: post,
                              ),

                        SavedNewsIcon(news: post)

                      ],
                    ),
                  ),
                ],
              ),
            ),SizedBox(
              height: Sizes.PADDING_16,
            ),
          ],
        ),
      ),
    );
  }



// _onShareWithEmptyOrigin(BuildContext context) async {
//   await Share.share("text");
// }

}








