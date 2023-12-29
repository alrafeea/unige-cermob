import 'dart:convert';

import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../CircularProgress.dart';

class SocialMediaLinks extends StatefulWidget {
  final NewsModel newsInfo;
  final bool isWebViewScroll;

  SocialMediaLinks({
    Key key,
    this.newsInfo,
    this.isWebViewScroll,
  }) : super(key: key);

  @override
  _SocialMediaLinksState createState() => _SocialMediaLinksState();
}

class _SocialMediaLinksState extends State<SocialMediaLinks> {
  bool isLoading = true;
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.RADIUS_40),
              topRight: Radius.circular(Sizes.RADIUS_40)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 10000),
            child: IgnorePointer(
              ignoring: !widget.isWebViewScroll,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: InAppWebView(
                    key: ValueKey(widget.newsInfo.url),
                    initialUrl: getInitialUrlContent(widget.newsInfo.url),
                    gestureRecognizers: Set()
                      ..add(
                        Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer(),
                        ), // or null
                      ),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: true,
                        useShouldOverrideUrlLoading: true,
                        preferredContentMode:
                            UserPreferredContentMode.RECOMMENDED,
                        cacheEnabled: true,
                        disableVerticalScroll: !widget.isWebViewScroll,
                      ),
                    ),

                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      print("");
                    },
                    shouldOverrideUrlLoading: (controller, request) async {
                      var url = request.url;
                      return ShouldOverrideUrlLoadingAction.CANCEL;
                    },

                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      setState(() {
                        isLoading = false;
                      });
                    },

                    onProgressChanged: (InAppWebViewController controller,
                        int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        progress > 0 && progress<1
            ? Center(
          child: SizedBox(
            width: 40.0,
            height: 20.0,
            child: CircleProgressBar(
              background:
              Theme
                  .of(context)
                  .primaryColor,
              value: progress,
            ),
          ),
        )
            : Stack()
      ],
    );
  }

  getInitialUrlContent(String url) {
    if(url.indexOf('facebook') > -1){
      return Uri.dataFromString(
          '<html><header><meta name="viewport" content="width=device-width, initial-scale=1.0"></header><body> <script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script> <div class="fb-post"  data-href="${widget
              .newsInfo.url}"  ></div> </body> </html>',
          mimeType: 'text/html', encoding: Encoding.getByName("UTF-8"))
          .toString();
    }
    if(url.indexOf('twitter')>1) {
      return Uri.dataFromString(
          '<html><header><meta name="viewport" content="width=device-width, initial-scale=1.0"></header><body>  <blockquote class="twitter-tweet"><p lang="en" dir="ltr"></p> <a href="${widget.newsInfo.url}"></a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> </body> </html>',
          mimeType: 'text/html', encoding: Encoding.getByName("UTF-8"))
          .toString();
    }
    return url;
  }
}
