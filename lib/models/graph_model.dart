import 'package:charts_flutter/flutter.dart' as charts;
import 'package:therapia/constants/colors.dart';

class GraphModel {
  String day;
  double tremorIndex;
  charts.Color colour;

  GraphModel({
    required this.day,
    required this.tremorIndex,
    required this.colour,
  });

  static List<GraphModel> data = [
    GraphModel(
      day: '17',
      tremorIndex: 5.0,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
    GraphModel(
      day: '18',
      tremorIndex: 4.8,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
    GraphModel(
      day: '19',
      tremorIndex: 4.7,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
    GraphModel(
      day: '20',
      tremorIndex: 4.2,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
    GraphModel(
      day: '21',
      tremorIndex: 3.8,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
    GraphModel(
      day: '22',
      tremorIndex: 4.1,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
    GraphModel(
      day: '23',
      tremorIndex: 3.5,
      colour: charts.ColorUtil.fromDartColor(apnaDark),
    ),
  ];
}
