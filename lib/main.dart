import 'package:flutter/material.dart';
import 'package:mydoc/screens/home_screen.dart';
import 'package:mydoc/screens/welcome_screen.dart';
import 'package:mydoc/widgets/navbar_roots.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}