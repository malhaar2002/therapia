import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:therapia/models/graph_model.dart';

class Graphs extends StatelessWidget {
  Graphs({super.key});

  final List<charts.Series<GraphModel, String>> series = [
    charts.Series(
      id: 'Weekly Graph',
      data: GraphModel.data,
      domainFn: (GraphModel series, _) => series.day,
      measureFn: (GraphModel series, _) => series.tremorIndex,
      colorFn: (GraphModel series, _) => series.colour,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 600,
      padding: const EdgeInsets.all(50),
      child: charts.BarChart(
        series,
        animate: true,
      ),
    );
  }
}