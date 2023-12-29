import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/cards/rating_item.dart';
import 'package:flutter/material.dart';

import '../text.dart';

class ExpertRatingRow extends StatelessWidget {
  ExpertRatingRow({
    Key key, @required this.newsInfo,
  });
  final NewsModel newsInfo;

  @override
  Widget build(BuildContext context) {
    return newsInfo.expertRatingCounter == null
        ? Container()
        : Container(
            width: assignWidth(context: context, fraction: 0.290),
            height: 30,
            margin: EdgeInsets.only(left: 1, right: 1),
            child: ListView(
              scrollDirection: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CertifyIcon.star_withbg,
                  color: AppColors.blackShade6,
                  size: 24,
                ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.trueRating != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.trueRating}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.True,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.mostlyTrue != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.mostlyTrue}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.MostlyTrue,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.falseRating != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.falseRating}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.False,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.mostlyFalse != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.mostlyFalse}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.MostlyFalse,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.mixMix != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.mixMix}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.MixMix,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.outdated != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.outdated}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.Outdated,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.scam != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.scam}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.Scam,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.miscaptioned != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.miscaptioned}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.Miscaptioned,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.rumour != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.rumour}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.Rumour,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
                if (newsInfo.expertRatingCounter != null &&
                    newsInfo.expertRatingCounter.unproven != null)
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 2),
                          child: Texts(
                            "${newsInfo.expertRatingCounter.unproven}",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RatingItem(
                          ratingKey: RatingKey.Unproven,
                          isSmall: true,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
  }
}
