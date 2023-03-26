import 'package:flutter/material.dart';
import 'package:mydoc/screens/admin/nav_bar.dart';
import 'package:mydoc/screens/auth/login_screen.dart';
import 'package:mydoc/screens/auth/signup_screen.dart';
import 'package:mydoc/screens/auth/welcome_screen.dart';
import 'package:mydoc/screens/patient/appointment_screen.dart';
import 'package:mydoc/screens/patient/booking_screen.dart';
import 'package:mydoc/widgets/dr_navbar_roots.dart';
import 'package:mydoc/widgets/patient_navbar_roots.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyDoc',
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const SignUpScreen(),
          '/home': (context) => const NavBarRoots(),
          '/drhome': (context) => const DrNavBarRoots(),
          '/Admhome': (context) => const AdminNavBar(),
          '/appointments': (context) => AppointmentScreen(),
          '/booking': (context) => const BookingPage()
        });
  }
}
