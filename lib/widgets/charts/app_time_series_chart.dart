import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:certifyapp/config/size_config.dart';
import 'package:certifyapp/widgets/data_display/list/flexible_container.dart';
import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/material.dart';

/// App Time Series Chart
/// [seriesList] the series list
/// [chartName] the name of the chart
/// [startDate] the start date
/// [endDate] the end date
class AppTimeSeriesChart extends StatelessWidget {
  AppTimeSeriesChart({
    Key key,
    @required this.seriesList,
    this.chartName = '',
    this.startDate,
    this.endDate,
  });

  final String chartName;
  final List<Series<dynamic, DateTime>> seriesList;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return FlexibleContainer(
      heightFactor: 0.47,
      child: Column(
        children: <Widget>[
          Texts(chartName, fontSize: SizeConfig.textMultiplier * 3),
          Container(
            height: SizeConfig.realScreenHeight * 0.37,
            child: Center(
              child: Container(
                child: charts.TimeSeriesChart(
                  seriesList,
                  animate: true,
                  behaviors: [
                    charts.RangeAnnotation(
                      [
                        charts.RangeAnnotationSegment(startDate, endDate,
                            charts.RangeAnnotationAxisType.domain),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
