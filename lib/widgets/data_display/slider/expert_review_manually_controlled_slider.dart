import 'package:carousel_slider/carousel_slider.dart';
import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/post/reviews/expert_review_model.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertReviewManuallyControlledSlider extends StatefulWidget {
  final List<ExpertReviewModel> reviewList;

  const ExpertReviewManuallyControlledSlider({Key key, this.reviewList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExpertReviewManuallyControlledSliderState();
  }
}

class _ExpertReviewManuallyControlledSliderState
    extends State<ExpertReviewManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();
  int current = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = assignHeight(context: context, fraction: 0.45);
    final List<Widget> imageSliders = widget.reviewList
        .map((review) => Container(
              height: height - 10,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(width: 1.0, color: const Color(0xffcccccc))),
              child: Stack(
                children: [
                  Positioned(
                    right: -15,
                    top: -10,
                    child: Icon(
                      RatingUtils.getRatingInofById(review.type.id.toString())
                          .icon,
                      color: RatingUtils.getRatingInofById(
                              review.type.id.toString())
                          .activeColor
                          .withOpacity(0.15),
                      size: 200,
                    ),
                  ),
                  Container(
                    width: assignWidth(context: context, fraction: 0.90),
                    height: height - 10,
                    padding: EdgeInsets.symmetric(horizontal: 15),

                    // margin: EdgeInsets.symmetric(vertical: ),

                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: review.user.displayName + "" ?? "",
                                    style: Styles.ratingTextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: Sizes.TEXT_SIZE_22,
                                        color: AppColors.blackShade5)),
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () async {
                                      await launch(review.expert.profileUrl);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5),
                                      child: Icon(
                                        FontAwesomeIcons.externalLinkAlt,
                                        color: Color(0xFF00A1ED),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SpaceH12(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                        width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.28,
                                      child: RichText(
                                         overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        text: TextSpan(
                                          children: [
                                            if (review.expert.logo != null)
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Image.network(
                                                  review.expert.logo,
                                                  height: 50,
                                                  width: 40,
                                                ),
                                              ),
                                            TextSpan(
                                              text: "(" +
                                                  (review.expert.name + "" ??
                                                      '') +
                                                  ")",
                                              style: Styles.ratingTextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Sizes.TEXT_SIZE_18,
                                                  color: AppColors.greyShade7),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  margin: EdgeInsets.only(top: 12, left: 18),
                                  child: Container(
                                    color: Colors.transparent,
                                    // top: 10,
                                    // right: 40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                  onTap: current == 1
                                                      ? null
                                                      : () {
                                                          _controller
                                                              .previousPage();
                                                        },
                                                  child: Icon(
                                                    CertifyIcon.back,
                                                    color: current == 1
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    size: 20,
                                                  )),
                                              Flexible(
                                                child: Text(
                                                    current.toString() +
                                                        '/' +
                                                        widget.reviewList.length
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          Sizes.TEXT_SIZE_20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: current ==
                                                        widget.reviewList.length
                                                    ? null
                                                    : () {
                                                        _controller.nextPage();
                                                      },
                                                child: Icon(
                                                  CertifyIcon.forowrd,
                                                  color: current ==
                                                          widget
                                                              .reviewList.length
                                                      ? Colors.grey
                                                      : Colors.black,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 5, left: 5),
                                        ),
                                        Text(
                                          'Validations',
                                          textAlign: TextAlign.center,
                                          style: Styles.ratingTextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: Sizes.TEXT_SIZE_18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                RatingUtils.getRatingInofById(
                                        review.type.id.toString())
                                    .label,
                                style: Styles.ratingTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.TEXT_SIZE_18,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),

                        SpaceH24(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Claims",
                              style: Styles.ratingTextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: Sizes.TEXT_SIZE_18,
                                color: Color(0xFF313133),
                              ),
                            ),
                            SpaceH8(),
                            Column(
                              children: review.claims.map((claims) {
                                return Row(children: [
                                  Expanded(
                                    child: Text(
                                      claims.isEmpty ? 'N/A' : claims,
                                      style: Styles.ratingTextStyle(
                                        fontSize: Sizes.TEXT_SIZE_14,
                                        color: Color(0xFF96999C),
                                      ),
                                    ),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ],
                        ),
                        SpaceH24(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("What’s true",
                                style: Styles.ratingTextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: Sizes.TEXT_SIZE_18,
                                  color: Color(0xFF313133),
                                )),
                            SpaceH8(),
                            Row(children: [
                              Expanded(
                                child: Text(
                                  review.whatIsTrue.isEmpty
                                      ? 'N/A'
                                      : review.whatIsTrue,
                                  style: Styles.ratingTextStyle(
                                    fontSize: Sizes.TEXT_SIZE_14,
                                    color: Color(0xFF96999C),
                                  ),
                                ),
                              ),
                            ])
                          ],
                        ),
                        SpaceH24(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("What’s False",
                                style: Styles.ratingTextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: Sizes.TEXT_SIZE_18,
                                  color: Color(0xFF313133),
                                )),
                            SpaceH8(),
                            Row(children: [
                              Expanded(
                                child: Text(
                                    review.whatIsFalse.isEmpty
                                        ? 'N/A'
                                        : review.whatIsFalse,
                                    style: Styles.ratingTextStyle(
                                      fontSize: Sizes.TEXT_SIZE_14,
                                      color: Color(0xFF96999C),
                                    )),
                              ),
                            ])
                          ],
                        ),
                        SpaceH36(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ))
        .toList();

    return SingleChildScrollView(
      child: CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            height: height,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, _) {
              setState(() {
                current = index + 1;
              });
            }),
        carouselController: _controller,
      ),
    );
  }
}
