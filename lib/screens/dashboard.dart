import 'package:flutter/material.dart';
import 'package:therapia/constants/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: apnaRed,
        child: const Icon(Icons.add),
      ),
      backgroundColor: apnaSkin,
      appBar: AppBar(
        backgroundColor: apnaRed,
        title: const Text('Therapia'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: apnaYellow,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
