import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:therapia/constants/colors.dart';
import 'package:therapia/models/graph_model.dart';

class Graphs extends StatefulWidget {
  const Graphs({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Graphs> createState() =>
      _GraphsState(timeDuration: GraphModel.monthData);
}

class _GraphsState extends State<Graphs> {
  List<GraphModel> timeDuration;
  _GraphsState({required this.timeDuration});

  List<charts.Series<GraphModel, num>> series = [];

  @override
  void initState() {
    super.initState();
    series = [
      charts.Series(
        id: 'Weekly Graph',
        data: timeDuration,
        domainFn: (GraphModel series, _) => series.day,
        measureFn: (GraphModel series, _) => series.tremorIndex,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(apnaDark),
      )
    ];
  }

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
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: apnaLight,
        ),
        width: MediaQuery.of(context).size.width,
        child: charts.LineChart(
          series,
          defaultRenderer: charts.LineRendererConfig(
            includeArea: true,
            stacked: true,
            strokeWidthPx: 3,
          ),
          animate: true,
          domainAxis: const charts.NumericAxisSpec(
            showAxisLine: false,
            renderSpec: charts.NoneRenderSpec(),
          ),
          primaryMeasureAxis: const charts.NumericAxisSpec(
            renderSpec: charts.NoneRenderSpec(),
          ),
          layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fixedPixel(0),
            rightMarginSpec: charts.MarginSpec.fixedPixel(0),
            topMarginSpec: charts.MarginSpec.fixedPixel(0),
            bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
          ),
        ),
      ),
    );
  }
}
