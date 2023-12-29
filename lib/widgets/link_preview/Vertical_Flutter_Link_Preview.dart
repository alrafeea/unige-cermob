
import 'package:cached_network_image/cached_network_image.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/CircularProgress.dart';
import 'package:certifyapp/widgets/data_display/cards/social_media_links.dart';
import 'package:certifyapp/widgets/news/time_ago.dart';
import 'package:certifyapp/widgets/news/view_source.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_preview/flutter_link_preview.dart';

class VerticalFlutterLinkPreview extends StatelessWidget {
   VerticalFlutterLinkPreview(
      {Key key,
      @required this.post,
      this.hasBgColor = true,
      this.imageWidthFraction = 0.7,
      this.titleMaxLines = 1,
      this.imageHeightFraction = 0.24,
      this.isSourceShow = true,
      this.isWebViewScroll = true,
      this.fontSize = 13})
      : super(key: key);

  final NewsModel post;
  final hasBgColor;
  final double imageWidthFraction;
  final double imageHeightFraction;
  final double fontSize;

  final int titleMaxLines;
  final bool isSourceShow;
  final bool isWebViewScroll;

  @override
  Widget build(BuildContext context) {
    return Utils.isSocialMediaLinks(url: post.url)
        ? Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: hasBgColor ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(Sizes.RADIUS_40),
                    // border:  Border.all(
                  ),
                  // height: assignHeight(context: context, fraction: imageHeightFraction),
                  height: assignHeight(context: context, fraction: imageHeightFraction+0.037),
                  child: SocialMediaLinks(
                    newsInfo: post,
                    isWebViewScroll: isWebViewScroll,

                  )),
              NewsInof(post: post, isSourceShow: isSourceShow),
            ],
    ):
    FlutterLinkPreview(
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
        if (info == null && error != null ) return Container(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/images/no-result.png', height: 120,),
              Text(
                "View is not available!",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Helvetica_Neue_LTStd"
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  "We cant access this link for now, please check the Source",
                  // maxLines: titleMaxLines,
                  // overflow: titleMaxLines>1?TextOverflow.ellipsis: TextOverflow.visible,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Helvetica_Neue_LTStd"
                  ),
                ),
              ),
              SizedBox(height: 20,),
              NewsInof(post: post,isSourceShow: true,)
            ],
          ),
        ),);
        if (info == null) return AppCircularProgressIndicator();
        if (info is WebInfo ) {
          post.title = info.title??"";
          post.description = info.description??"";
          return SizedBox(
            height: assignHeight(context: context, fraction: 0.30),
            child: Container(
              decoration: BoxDecoration(
                color: hasBgColor ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(Sizes.RADIUS_40),

                // border:  Border.all(
                //     width: 1.0, color: const Color(0xffcccccc)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (info.image != null)
                    ImageDisplay(
                      image: info.image,
                      imageWidthFraction: imageWidthFraction ?? 0.7,
                      imageHeightFraction: imageHeightFraction ?? 0.24,
                    ),
                  NewsInof(post: post, isSourceShow: isSourceShow),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 5),
                      child: Text(
                        info.title,
                        maxLines: titleMaxLines,
                        overflow: titleMaxLines>1?TextOverflow.ellipsis: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Helvetica_Neue_LTStd"
                        ),
                      ),
                    ),
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
                borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
              ),
              child: ImageDisplay(image: info.image, imageWidthFraction: imageWidthFraction,),
            ),
          );
        } else if (info is WebVideoInfo) {
          return SizedBox(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
                ),
                child: ImageDisplay(
                  image: info.image, imageWidthFraction: imageWidthFraction,
                )),
          );
        }
        // return AppCircularProgressIndicator();
      },
     );
   }
}

class NewsInof extends StatelessWidget {
  const NewsInof({
    Key key,
    @required this.post,
    @required this.isSourceShow,
  }) : super(key: key);

  final NewsModel post;
  final bool isSourceShow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0),
          child: PostSourceName(post: post),
        ),
        if(isSourceShow)
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0),
            child: ViewSource(url: post.url,),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0),
          child: TimeAgo(createdAt: post.createdAt),
        ),
      ],);
  }
}

class PostSourceName extends StatelessWidget {
  const PostSourceName({
    Key key,
    @required this.post,
  }) : super(key: key);

  final NewsModel post;

  @override
  Widget build(BuildContext context) {
    return Text(
      post.source??'',
      style: TextStyle(
          fontSize: Sizes.TEXT_SIZE_10,
          // fontWeight: FontWeight.bold,
          color: AppColors.blackShade7),
    );
  }
}

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key key,
    @required this.image, this.imageWidthFraction, this.imageHeightFraction,
  }) : super(key: key);
  final String image;
  final double imageWidthFraction;
  final double imageHeightFraction;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.RADIUS_20),
          topRight: Radius.circular(Sizes.RADIUS_20)),
      child: Container(
        height: assignHeight(context: context, fraction: imageHeightFraction),
        width: assignWidth(context: context, fraction: imageWidthFraction),
        child: CachedNetworkImage(
          imageUrl: image,
            maxWidthDiskCache:500,
          maxHeightDiskCache: 500,
          progressIndicatorBuilder: (BuildContext context, image,
              downloadProgress) {
            if (downloadProgress == null) return AppCircularProgressIndicator();
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 20.0,
                child: CircleProgressBar(
                  background: Theme.of(context).primaryColor,
                  value: downloadProgress.totalSize != null
                      ? downloadProgress.downloaded /
                      downloadProgress.totalSize
                      : 0,
                ),
              ),
            );
          },
          errorWidget: (_, __, x) {
            return Container(child: Icon(Icons.link));
          },
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  onError: (_,__){
                    return const Icon(Icons.link);
                  }
                 ),
            ),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
