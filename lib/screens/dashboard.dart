import 'package:flutter/material.dart';
import 'package:therapia/constants/colors.dart';
import 'package:therapia/widgets/graphs.dart';
import 'package:therapia/widgets/calendar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apnaDark,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: apnaLight,
              child: const Graphs(),
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(
            flex: 8,
            child: Calendar(),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'test');
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0))),
                  backgroundColor: MaterialStateProperty.all(apnaLight),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                ),
                child: const Text("Take Test",
                    style: TextStyle(fontSize: 20, color: apnaDark)),
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
