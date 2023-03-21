import 'package:flutter/material.dart';
import 'package:mydoc/screens/auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const double _imageHeight = 0.75;
  static const double _titleFontSize = 30;
  static const double _subtitleFontSize = 18;
  static const double _buttonFontSize = 22;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: const Key('welcome_screen'),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * _imageHeight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('images/doctors.png'),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Doctors Appointment',
              style: TextStyle(
                color: Color(0xFF7165D6),
                fontSize: _titleFontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Appoint Your Doctor',
              style: TextStyle(
                color: Colors.black54,
                fontSize: _subtitleFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: const Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _buttonFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
