import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<String> toHighlight = [];

  void initState() {
    getData();
    super.initState();
  }


  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    toHighlight = (await prefs.getStringList('toHighlight')) ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00c29a),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff0c0d1b),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 90),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
            child: Column(
              children: [
                TableCalendar(
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      if (toHighlight != []) {
                        for (String date in toHighlight) {
                          DateTime d = DateFormat("yyyy-MM-dd").parse(date);
                          if (day.day == d.day &&
                              day.month == d.month &&
                              day.year == d.year) {
                            return Container(
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff00c29a),
                              ),
                              child: const Center(
                                child: Icon(Icons.check, color: Colors.white),
                              ),
                            );
                          }
                        }
                      }
                      return null;
                    },
                    todayBuilder: (context, day, focusedDay) {
                      if (toHighlight != []) {
                        for (String date in toHighlight) {
                          DateTime d = DateFormat("yyyy-MM-dd").parse(date);
                          if (day.day == d.day &&
                              day.month == d.month &&
                              day.year == d.year) {
                            return Container(
                              margin: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff00c29a),
                              ),
                              child: Center(
                                child: Text(DateTime.now().day.toString(),
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            );
                          }
                        }
                      }
                      return null;
                    },
                  ),

                  //shouldFillViewport: true,
                  firstDay: DateTime.utc(2021, 11, 22),
                  lastDay: DateTime.utc(2030, 11, 22),
                  focusedDay: DateTime.now(),
                  //##################################################
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    weekdayStyle: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  //##################################################
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: Colors.white)),
                  //##################################################
                  calendarStyle: const CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black),
                    outsideTextStyle: TextStyle(color: Colors.white60),
                    defaultTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    weekendTextStyle: TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                analysisToday(),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Set Goal",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        const Divider(thickness: 1, color: Colors.black87),
                        Row(
                          children: [
                            const Text(
                              "Meditation Time (per day)",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            Expanded(child: Container()),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                formatDuration(duration),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              onPressed: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                          actions: [buildPicker()],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            child: const Text(
                                              "Done",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPicker() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: CupertinoTimerPicker(
          initialTimerDuration: duration,
          mode: CupertinoTimerPickerMode.hms,
          onTimerDurationChanged: ((value) async {
            if (value != const Duration(seconds: 0)) {
              setState(() {
                duration = value;
              });
            }

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setStringList('goalTime', [
              formatDuration(duration).substring(0, 2),
              formatDuration(duration).substring(3, 5),
              formatDuration(duration).substring(6, 8)
            ]);
          }),
        ),
      ),
    );
  }

  Widget analysisToday() {
    double percent = 0;
    if ((durationDone.inSeconds / duration.inSeconds) >= 1) {
      if (DateFormat("yyyy-MM-dd").format(DateTime.now()) != lastCompleteDay) {
        markToday();
      }
      percent = 1;
    } else {
      percent = durationDone.inSeconds / duration.inSeconds;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              children: [
                const Text(
                  "Today's Effort",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 94,
                      width: 94,
                      child: CircularPercentIndicator(
                        radius: 47,
                        lineWidth: 12,
                        percent: percent,
                        circularStrokeCap: CircularStrokeCap.round,
                        reverse: true,
                        progressColor: const Color(0xff00c29a),
                        backgroundColor: const Color(0xff0c0d1b),
                        center: Text(
                          "${(durationDone.inSeconds / duration.inSeconds * 100).floor()}%",
                          style: const TextStyle(
                              color: Color(0xff00c29a), fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const VerticalDivider(
              color: Colors.black54,
              thickness: 2,
              indent: 5,
              endIndent: 5,
              width: 30,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    streak.toString(),
                    style: const TextStyle(
                      fontSize: 40,
                      color: Color(0xff00c29a),
                    ),
                  ),
                  const Text(
                    "DAYS STREAK",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  }
