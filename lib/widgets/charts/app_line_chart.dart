import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// chart line
/// [seriesList] charts series
/// [chartTitle] the charts title
/// [animate] enable and disable animate on create chart
/// [includeArea] chart include Area
/// [stacked] stacked chart over the design
class AppLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final String chartTitle;
  final bool animate;
  final bool includeArea;
  final bool stacked;

  AppLineChart(
      {Key key,
      @required this.seriesList,
      this.chartTitle,
      this.animate = true,
      this.includeArea = false,
      this.stacked = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            chartTitle,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: charts.LineChart(seriesList,
                defaultRenderer: charts.LineRendererConfig(
                    includeArea: false, stacked: true),
                animate: animate),
          ),
        ],
      ),
    );
  }
}
