import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/viewModels/news_view_model.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/widgets/charts/user_review_bar_chart.dart';
import 'package:certifyapp/widgets/data_display/no_result_widget.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../adaptive.dart';

class ShowUserValidation extends StatelessWidget {
  final NewsViewModel model;
  List<charts.Series> seriesList;

  ShowUserValidation({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.getUserValidationSum();
    seriesList = _createUserReviewData();
    double height = assignHeight(context: context, fraction: 0.60);

    return model.state == ViewState.Busy
        ? AppCircularProgressIndicator()
        : model.userReviewsList.isEmpty
            ? NoResultMsg()
            : Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xffcccccc),
                  ),
                ),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          right: -15,
                          top: -10,
                          child: Icon(
                            model.maxUserCountRatingKey.getRatingInof().icon,
                            color: model.maxUserCountRatingKey
                                .getRatingInof()
                                .activeColor
                                .withOpacity(0.15),
                            size: 230,
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          child: Center(
                            child: Container(
                              width:
                                  assignWidth(context: context, fraction: 0.9),
                              // height: height,
                              // color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              // margin: EdgeInsets.symmetric(vertical: ),

                              child: Container(
                                  height: assignHeight(
                                      context: context, fraction: 0.3),
                                  child: UserReviewBarChart(
                                    seriesList: seriesList,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Largest Label",
                                    style: TextStyle(
                                      color: Color(0xFF6D6F72),
                                      fontSize: 12.0,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Flexible(
                                  child: Text(
                                    model.maxUserCountRatingKey
                                        .getRatingInof()
                                        .label,
                                    style: TextStyle(
                                      color: Color(0xFF464749),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Flexible(
                                  child: Text(
                                    '${(model.maxUserRatingCount / model.totalUserRating * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Flexible(
                                  child: Text("Total Validations",
                                      style: TextStyle(
                                        color:Color(0xFF6D6F72),
                                        fontSize: 12.0,
                                        // fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Flexible(
                                  child: Text(model.totalUserRating.toString(),
                                      style: TextStyle(
                                        color: Color(0xFF464749),
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }

  /// Create series list with single series
  List<charts.Series<BarUserReview, String>> _createUserReviewData() {
    final userReviewsData = [
      new BarUserReview(
          'True',
          model.userRatingCounterSum.trueRating != 0
              ? model.userRatingCounterSum.trueRating / model.totalUserRating
              : 0),
      new BarUserReview(
          'Mostly True',
          model.userRatingCounterSum.mostlyTrue != 0
              ? model.userRatingCounterSum.mostlyTrue / model.totalUserRating
              : 0),
      new BarUserReview(
          'False',
          model.userRatingCounterSum.falseRating != 0
              ? model.userRatingCounterSum.falseRating / model.totalUserRating
              : 0),
      new BarUserReview(
          'Mostly False',
          model.userRatingCounterSum.mostlyFalse != 0
              ? model.userRatingCounterSum.mostlyFalse / model.totalUserRating
              : 0),
      new BarUserReview(
          'Outdated',
          model.userRatingCounterSum.outdated != 0
              ? model.userRatingCounterSum.outdated / model.totalUserRating
              : 0),
      new BarUserReview(
          'Rumour',
          model.userRatingCounterSum.rumour != 0
              ? model.userRatingCounterSum.rumour / model.totalUserRating
              : 0),
      new BarUserReview(
          'Unproven',
          model.userRatingCounterSum.unproven != 0
              ? model.userRatingCounterSum.unproven / model.totalUserRating
              : 0),
      new BarUserReview(
          'Mix Mix',
          model.userRatingCounterSum.mixMix != 0
              ? model.userRatingCounterSum.mixMix / model.totalUserRating
              : 0),
      new BarUserReview(
          'Miscaptioned ',
          model.userRatingCounterSum.miscaptioned != 0
              ? model.userRatingCounterSum.miscaptioned / model.totalUserRating
              : 0),
      new BarUserReview(
          'Scam',
          model.userRatingCounterSum.scam != 0
              ? model.userRatingCounterSum.scam / model.totalUserRating
              : 0),
    ];

    return [
      new charts.Series<BarUserReview, String>(
        id: 'UserReview',
        domainFn: (BarUserReview item, _) => item.label,
        measureFn: (BarUserReview item, _) => item.value * 100,
        fillColorFn: (BarUserReview item, __) =>
            charts.ColorUtil.fromDartColor(item.label == model.maxUserCountRatingKey
                .getRatingInof().label?Color(0xFFBF0053):Color(0xFFC7C9CB)),
        insideLabelStyleAccessorFn: (_, __) {
          return charts.TextStyleSpec(fontSize: 8);
        },
        data: userReviewsData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class BarUserReview {
  final String label;
  final double value;

  BarUserReview(this.label, this.value);
}
