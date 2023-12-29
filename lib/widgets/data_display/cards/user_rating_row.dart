import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/cards/rating_item.dart';
import 'package:flutter/material.dart';

import '../text.dart';

// ignore: must_be_immutable
class UserRatingRow extends StatelessWidget {
  UserRatingRow({
    Key key,
    @required this.newsInfo,
  });

  final NewsModel newsInfo;
  int maxRating;
  String maxRatingType;

  int getUserRating(RatingCounter userRatingCounter) {
    int userRating = (userRatingCounter.trueRating ??
        0) + (userRatingCounter.falseRating ??
        0) + (userRatingCounter.mostlyFalse ??
        0) + (userRatingCounter.mostlyTrue ??
        0) + (userRatingCounter.mixMix ??
        0) + (userRatingCounter.outdated ??
        0 )+ (userRatingCounter.scam ??
        0) + (userRatingCounter.miscaptioned ??
        0 )+ (userRatingCounter.rumour ??
        0) + (userRatingCounter.unproven ?? 0);

    return userRating;
  }

  getMaxInRatingAndType(RatingCounter userRatingCounter) {
    maxRating = userRatingCounter.trueRating ?? 0;

    maxRatingType = "trueRating";

    if ((userRatingCounter.falseRating ?? 0) > maxRating) {
      maxRating = userRatingCounter.falseRating ?? 0;
      maxRatingType = "falseRating";
    }
    if ((userRatingCounter.mostlyTrue ?? 0) > maxRating) {
      maxRating = userRatingCounter.mostlyTrue ?? 0;
      maxRatingType = "mostlyTrue";
    }
    if ((userRatingCounter.mostlyFalse ?? 0) > maxRating) {
      maxRating = userRatingCounter.mostlyFalse ?? 0;
      maxRatingType = "mostlyFalse";
    }
    if ((userRatingCounter.mixMix ?? 0) > maxRating) {
      maxRating = userRatingCounter.mixMix ?? 0;
      maxRatingType = "mixMix";
    }
    if ((userRatingCounter.scam ?? 0) > maxRating) {
      maxRating = userRatingCounter.scam ?? 0;
      maxRatingType = "scam";
    }
    if ((userRatingCounter.rumour ?? 0) > maxRating) {
      maxRating = userRatingCounter.rumour ?? 0;
      maxRatingType = "rumour";
    }
    if ((userRatingCounter.outdated ?? 0) > maxRating) {
      maxRating = userRatingCounter.outdated ?? 0;
      maxRatingType = "outdated";
    }
    if ((userRatingCounter.unproven ?? 0) > maxRating) {
      maxRating = userRatingCounter.unproven ?? 0;
      maxRatingType = "unproven";
    }
    if ((userRatingCounter.miscaptioned ?? 0) > maxRating) {
      maxRating = userRatingCounter.miscaptioned ?? 0;
      maxRatingType = "miscaptioned";
    }

    // + userRatingCounter.mostlyFalse ??
    //   0 + userRatingCounter.mostlyTrue ??
    //   0 + userRatingCounter.mixMix ??
    //   0 + userRatingCounter.outdated ??
    //   0 + userRatingCounter.scam ??
    //   0 + userRatingCounter.miscaptioned ??
    //   0 + userRatingCounter.rumour ??
    //   0 + userRatingCounter.unproven ??
    //   0;
  }

  @override
  Widget build(BuildContext context) {
    if (newsInfo.userRatingCounter != null)
      getMaxInRatingAndType(newsInfo.userRatingCounter);
    return newsInfo.userRatingCounter == null
        ? Container()
        : Container(
            child: Row(
              children: [
                Icon(CertifyIcon.person2, color: AppColors.blackShade6),
                Texts(
                  "$maxRating/" +
                      getUserRating(newsInfo.userRatingCounter).toString(),
                  fontSize: 15,
                  color: Colors.grey,
                ),
                if (newsInfo.userRatingCounter != null &&
                    newsInfo.userRatingCounter.trueRating != null &&
                    maxRatingType == "trueRating")
                  Container(
                    padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.True, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.mostlyTrue!=null && maxRatingType == "mostlyTrue")
            Container(   padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.MostlyTrue, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.falseRating!=null && maxRatingType == "falseRating")
            Container(   padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.False, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.mostlyFalse!=null && maxRatingType == "mostlyFalse")
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.MostlyFalse, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.mixMix!=null && maxRatingType == "mixMix")
            Container(   padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.MixMix, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.outdated!=null && maxRatingType == "outdated")
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.Outdated, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.scam!=null && maxRatingType == "scam")
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.Scam, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.miscaptioned!=null && maxRatingType == "miscaptioned")
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.Miscaptioned, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.rumour!=null && maxRatingType == "rumour")
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.Rumour, isSmall: true,),
            ),
          if(newsInfo.userRatingCounter !=null  && newsInfo.userRatingCounter.unproven!=null && maxRatingType == "unproven")
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: RatingItem(ratingKey: RatingKey.Unproven, isSmall: true,),
            ),
        ],
      ),
    );

  }
}
