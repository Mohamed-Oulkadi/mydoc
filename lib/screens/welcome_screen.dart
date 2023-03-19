import 'package:flutter/material.dart';
import 'package:mydoc/screens/auth/login_screen.dart';

import '../widgets/navbar_roots.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 100),
            Padding(padding: EdgeInsets.all(20),child: Image.asset("images/doctors.png"),
            ),
            SizedBox(height: 50),
            Text(
              "Doctors Appointment",
              style: TextStyle(
                color: Color(0xFF7165D6),
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Appoint Your Doctor",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap:() {
                      Navigator.push(context,
                       MaterialPageRoute(
                        builder: (context) =>NavBarRoots(),
                      ));
                    },
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
