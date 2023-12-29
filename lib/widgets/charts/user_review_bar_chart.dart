import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
/// Example of hiding both axis.
// ignore: must_be_immutable
class UserReviewBarChart extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;

  UserReviewBarChart({this.seriesList, this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      customSeriesRenderers: [],
      barGroupingType: charts.BarGroupingType.stacked,
      behaviors: [],
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: -90,
          labelOffsetFromTickPx: -4,
          tickLengthPx: 0,
          labelStyle: TextStyleSpec(
              fontSize: 10,
              fontWeight: "FontWeight.bold",
              color: Color.fromHex(code: '#C7C9CB')),
          lineStyle:
          LineStyleSpec(thickness: 2, color: Color(r: 70, g: 71, b: 73),),
          labelAnchor: charts.TickLabelAnchor.before,
        ),
      ),
    );

  }
}