import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:therapia/constants/colors.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<String> toHighlight = [];

  @override
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
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
      child: TableCalendar(
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
                      color: apnaGreen,
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
                      color: apnaGreen,
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
              color: apnaLight, fontWeight: FontWeight.bold, fontSize: 16),
          weekdayStyle: TextStyle(
              color: apnaLight, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        //##################################################
        headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white)),
        //##################################################
        calendarStyle: const CalendarStyle(
          todayTextStyle: TextStyle(color: Colors.black),
          outsideTextStyle: TextStyle(color: Colors.white60),
          defaultTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          weekendTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: apnaLight,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
