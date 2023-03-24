import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydoc/screens/patient/home_screen.dart';
import 'package:mydoc/screens/patient/schedule_screen.dart';
import 'package:mydoc/screens/chat/messages_screen.dart';
import 'package:mydoc/screens/patient/settings_screen.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({Key? key}) : super(key: key);

  @override
  NavBarRootsState createState() => NavBarRootsState();
}

class NavBarRootsState extends State<NavBarRoots> {
  late int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    const ScheduleScreen(),
    const MessagesScreen(),
    const SettingScreen(),
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
              icon: Icon(Icons.calendar_month),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text_fill),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
