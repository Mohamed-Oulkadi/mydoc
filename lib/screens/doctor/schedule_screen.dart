import 'package:flutter/material.dart';

import '../../components/button.dart';
import '../../main.dart';
import '../../providers/utils.dart';
// import 'package:mydoc/screens/schedule/upcoming_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;

  final _scheduleWidgets = [
    // TODO fix this
    // UpcomingSchedule(),
    const Center(
      child: Text("Completed"),
    ),
    Container(
      child: const Text("Canceled"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Material(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Schedule",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 0
                              ? const Color(0xFF7165D6)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _buttonIndex == 0
                                  ? Colors.white
                                  : Colors.black38),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 1
                              ? const Color(0xFF7165D6)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _buttonIndex == 1
                                  ? Colors.white
                                  : Colors.black38),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 2;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 2
                              ? const Color(0xFF7165D6)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Canceled",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _buttonIndex == 2
                                  ? Colors.white
                                  : Colors.black38),
                        ),
                      )),
                ],
              )),
          const SizedBox(height: 30),
          _scheduleWidgets[_buttonIndex],

          const SizedBox(height: 30),
          InkWell(
              onTap: () async {
                showScreen(context, '/availability');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Change availability date",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
        ],
      )),
    );
  }
}
