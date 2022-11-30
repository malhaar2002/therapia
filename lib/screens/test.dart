import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapia/screens/dashboard.dart';
import 'package:therapia/screens/result.dart';
import '../constants/colors.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Duration duration = const Duration(seconds: 30);
  Duration initialTime = const Duration(seconds: 30);
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  List<List> sensorData = [];
  Timer? timer;

  Future<void> addDate(double mf) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currData = (await prefs.getStringList('toHighlight')) ?? [];
    currData.add(DateFormat("yyyy-MM-dd").format(DateTime.now()));
    Set<String> currDataSet = {...currData};

    List<String> currSenData = (await prefs.getStringList('sensorData')) ?? [];
    currSenData.add(mf.toString());

    await prefs.setStringList('toHighlight', currDataSet.toList());
    await prefs.setStringList('sensorData', currSenData);
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (duration > const Duration(seconds: 0)) {
          setState(() {
            duration = duration - const Duration(seconds: 1);
          });
        } else {
          timer?.cancel();
        }
      },
    );
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  Future<double> getData() async {
    var dio = Dio();
    String listToString = '${sensorData}';
    var response = await dio
        .post('https://therap.herokuapp.com/', data: {"acc": listToString});
    String maxFrequencyString = response.data['maxFrequency'];
    double maxFrequency = double.parse(maxFrequencyString);
    return maxFrequency;
  }

  @override
  void initState() {
    startTimer();
    super.initState();

    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      sensorData.add(<double>[event.x, event.y, event.z]);
    }));
  }

  void stopSensor() {
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        timer?.cancel();
        stopSensor();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: apnaDark,
          title: const Text('Therapia'),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: apnaLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: duration.inSeconds / initialTime.inSeconds,
                      strokeWidth: 12,
                      color: Colors.white,
                      backgroundColor: apnaDark,
                    ),
                    buildCountDown(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountDown() {
    if (duration == const Duration(seconds: 0)) {
      return const Icon(
        Icons.check,
        color: apnaDark,
        size: 110,
      );
    } else {
      return Center(
        child: Text(
          formatDuration(duration),
          style: const TextStyle(color: apnaDark, fontSize: 35),
        ),
      );
    }
  }

  Widget buildButton() {
    if (duration == const Duration(seconds: 0)) {
      return OutlinedButton(
        onPressed: (() async {
          // Navigator.pop(context);
          stopSensor();
          double mf = await getData();
          addDate(mf);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ));
        }),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          side: const BorderSide(width: 2.0, color: apnaDark),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "Finish",
          style: TextStyle(color: apnaDark, fontSize: 20),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              side: const BorderSide(width: 2.0, color: apnaDark),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              stopTimer();
              stopSensor();
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.timer_off,
              color: apnaDark,
              size: 50,
            ),
          ),
        ],
      );
    }
  }
}
