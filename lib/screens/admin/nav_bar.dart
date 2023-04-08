import 'package:flutter/material.dart';
import 'package:mydoc/screens/admin/adminhome_screen.dart';
import 'package:mydoc/screens/admin/patiens_list.dart';
import 'add_doctor.dart';
import 'appointmentlist.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({Key? key}) : super(key: key);

  @override
  AdminNavBarRootsState createState() => AdminNavBarRootsState();
}

class AdminNavBarRootsState extends State<AdminNavBar> {
  late int _selectedIndex = 0;
  final List<Widget> _screens = [
    const AdminHomeScreen(),
    const PatientsListeScreen(),
    const AppointmentListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF7165D6),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4),
              label: "Doctors",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.personal_injury_rounded),
              label: "Patients",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Appointments",
            ),
          ],
        ),
      ),
    );
  }
}
