import 'package:flutter/material.dart';
import 'package:therapia/screens/dashboard.dart';
import 'package:therapia/screens/test.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'dashboard',
      routes: {
        'dashboard':(context) => const Dashboard(),
        'test':(context) => const Test(),
      },
    ); 
  }
}
