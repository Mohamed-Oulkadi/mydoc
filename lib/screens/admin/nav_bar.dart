import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydoc/screens/admin/AdminHome_screen.dart';
import 'add_doctor.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({Key? key}) : super(key: key);

  @override
  AdminNavBarRootsState createState() => AdminNavBarRootsState();
}

class AdminNavBarRootsState extends State<AdminNavBar> {
  late int _selectedIndex = 0;
  final List<Widget> _screens = [
    const AdminHomeScreen(),
    const AddNewDoctor(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF7165D6),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined),
              label: "Add",
            ),
          ],
        ),
      ),
    );
  }
}