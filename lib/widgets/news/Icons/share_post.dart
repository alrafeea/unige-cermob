import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/values/values.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class SharePostIcon extends StatelessWidget {
  final NewsModel post;

  const SharePostIcon({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          _onShare(
            context,
            text:
                '${post.url} \n \n Validated by ${post.counters.expertsValidations??0} experts and ${post.counters.usersValidations??0} user ',
            subject: "Share link form Certify App",
          );
        },
        child: Icon(
          CertifyIcon.share,
          color: AppColors.iconColor,
        ),
      ),
      margin: EdgeInsets.only(right: Sizes.MARGIN_8),
    );
  }

  _onShare(BuildContext context, {String text, String subject}) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();
    //
    // if (imagePaths.isNotEmpty) {
    //   await Share.shareFiles(imagePaths,
    //       text: text,
    //       subject: subject,
    //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    // } else {
    await Share.share(text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    // }
  }
}
