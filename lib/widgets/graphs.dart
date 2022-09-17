import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:therapia/constants/colors.dart';
import 'package:therapia/models/graph_model.dart';

class Graphs extends StatefulWidget {
  const Graphs({super.key});

  @override
  State<Graphs> createState() => _GraphsState();

}

class _GraphsState extends State<Graphs> {
  late List<GraphModel> timeDuration;

  final List<charts.Series<GraphModel, num>> series = [
    charts.Series(
      id: 'Weekly Graph',
      // FIXME: timeDuration not working
      // data: timeDuration,
      data:  GraphModel.monthData,
      domainFn: (GraphModel series, _) => series.day,
      measureFn: (GraphModel series, _) => series.tremorIndex,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(apnaDark),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apnaDark,
      appBar: AppBar(
        backgroundColor: apnaDark,
        title: const Text('Therapia'),
        actions: [
          TextButton(
            child: const Text(
              'Week',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => setState(() {
              timeDuration = GraphModel.weekData;
            }),
          ),
          TextButton(
            child: const Text(
              'Month',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => setState(() {
              timeDuration = GraphModel.monthData;
            }),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
          color: apnaLight,
        ),
        width: 500,
        height: 600,
        padding: const EdgeInsets.all(50),
        child: charts.LineChart(
          series,
          animate: true,
        ),
      ),
    );
  }
}