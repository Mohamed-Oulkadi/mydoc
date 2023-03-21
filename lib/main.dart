import 'package:flutter/material.dart';
import 'package:mydoc/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyDoc',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
