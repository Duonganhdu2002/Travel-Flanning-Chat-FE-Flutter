import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void greet() {
    debugPrint('Your message');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    greet();
    return const MaterialApp(
      home: Scaffold(),
    );
  }
}