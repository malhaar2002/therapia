import 'package:flutter/material.dart';
import 'package:therapia/constants/colors.dart';
import 'package:therapia/models/graph_model.dart';
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
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
                color: apnaLight,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: const Graphs(),
            ),
          ),
          const Expanded(
            flex: 3,
            child: Calendar(),
          )
        ],
      ),
    );
  }
}
