import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/CircularProgress.dart';
import 'package:certifyapp/widgets/data_display/cards/social_media_links.dart';
import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:certifyapp/widgets/news/time_ago.dart';
import 'package:certifyapp/widgets/news/view_source.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';

class HorizontalFlutterLinkPreview extends StatelessWidget {
  const HorizontalFlutterLinkPreview({
    Key key,
    @required this.post, this.imageWidthFraction= 0.45,
  }) : super(key: key);

  final NewsModel post;
  final double imageWidthFraction;

  @override
  Widget build(BuildContext context) {
    return Utils.isSocialMediaLinks(url: post.url)
        ? Container(
            margin: EdgeInsets.only(top: Sizes.MARGIN_20, right:Sizes.MARGIN_8 ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Sizes.MARGIN_48),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0),
                            child: TimeAgo(createdAt: post.createdAt),
                          ),
                          ViewSource(
                            url: post.url,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizes.RADIUS_20)),
                  child: Stack(
                    children: [
                      Container(
                        width: assignWidth(
                            context: context, fraction: imageWidthFraction +0.13),
                        height: assignHeight(context: context, fraction: 0.25),
                        child: SocialMediaLinks(
                          newsInfo: post,
                        ),
                      ),
                      SourceGrayTitle(post: post)
                    ],
                  ),
                )
              ],
            ),
          )
        : FlutterLinkPreview(
            url: post.url,
            key: ValueKey(post.url),
            bodyStyle: TextStyle(
              fontSize: 10.0,
            ),
            titleStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            // ignore: missing_return
            builder: (info, error) {
              if (info == null) return AppCircularProgressIndicator();
              if (info is WebInfo) {
                post.title = info.title;
                post.description = info.description;
                return SizedBox(
                  height: assignHeight(context: context, fraction: 0.20),
                  child: Container(
                    margin: EdgeInsets.only(top: Sizes.MARGIN_20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                          child: Text(
                            info.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: Sizes.TEXT_SIZE_16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SpaceH12(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0),
                              child: TimeAgo(createdAt: post.createdAt),
                            ),
                            ViewSource(
                              url: post.url,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (info.image != null)
                    ImageDisplay(
                      image: info.image,
                      post: post,
                      imageWidthFraction: imageWidthFraction,

                    ),
                ],
              ),
            ),
          );
        }
        if (info is WebImageInfo) {
          return SizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ImageDisplay(image: info.image,
                post: post,
              ),
            ),
          );
        } else if (info is WebVideoInfo) {
          return SizedBox(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ImageDisplay(
                  image: info.image,
                  post: post,

                )),
          );
        }
        // return AppCircularProgressIndicator();
      },
    );
  }
}



class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key key,
    @required this.image, @required this.post, this.imageWidthFraction,
  }) : super(key: key);
  final String image;
  final NewsModel post;
  final double imageWidthFraction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Sizes.MARGIN_8),
      height: assignHeight(context: context, fraction: 0.18),
      width: assignWidth(context: context, fraction: imageWidthFraction),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_20)),
        child: Stack(
          children: [
            Image.network(
              image,
              key: ValueKey(image),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 20.0,
                    child: CircleProgressBar(
                      background: Theme
                          .of(context)
                          .primaryColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                          : 0,
                    ),
                  ),
                );
              },
              width: assignWidth(
                  context: context, fraction: imageWidthFraction),
              fit: BoxFit.fill,
            ),
            SourceGrayTitle(post: post),
          ],
        ),
      ),
    );
  }
}

class SourceGrayTitle extends StatelessWidget {
  const SourceGrayTitle({
    Key key,
    @required this.post,
  }) : super(key: key);

  final NewsModel post;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Color(0xFF6D6F72).withOpacity(0.8),
        // width: assignWidth(context: context, fraction: 0.57),
        height: assignHeight(context: context, fraction: 0.05),
        child: Center(
            child: Texts(
              post.source,
              color: Colors.white,
              fontSize: 15,
              bold: true,
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
