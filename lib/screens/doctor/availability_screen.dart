import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mydoc/components/button.dart';
import 'package:mydoc/components/custom_appbar.dart';
import 'package:mydoc/main.dart';
import 'package:mydoc/models/booking_datetime_converted.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:mydoc/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range_picker/time_range_picker.dart';

var doctor;

void fetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  doctor = await json.decode(prefs.get('doctor') as String);
}

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreen();
}

class _AvailabilityScreen extends State<AvailabilityScreen> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? _startTime;
  String? _endTime;
  String? _selectedTime;

  Future<void> _show() async {
    TimeRange? result = await showTimeRangePicker(
        context: context,
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 12, minute: 0),
        disabledTime: TimeRange(
            startTime: const TimeOfDay(hour: 22, minute: 0),
            endTime: const TimeOfDay(hour: 5, minute: 0)),
        disabledColor: Colors.red.withOpacity(0.5),
        strokeWidth: 4,
        ticks: 24,
        ticksOffset: -7,
        ticksLength: 15,
        ticksColor: Colors.grey,
        labels: [
          "12 am",
          "3 am",
          "6 am",
          "9 am",
          "12 pm",
          "3 pm",
          "6 pm",
          "9 pm"
        ].asMap().entries.map((e) {
          return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
        }).toList(),
        labelOffset: 35,
        rotateLabels: false,
        padding: 60);

    _timeSelected = true;
    _startTime = result?.startTime.format(context);
    _endTime = result?.endTime.format(context);
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Availability',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: const Text(
                      'Weekend is already unavailable, please select another date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Button(
                    width: double.infinity,
                    title: 'Select Unavailability Time',
                    onPressed: () async {
                      _show();
                    },
                    disable: false,
                  ),
                )),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Button(
                width: double.infinity,
                title: 'Validate availability',
                onPressed: () async {
                  //convert date into string first
                  final getDate = DateConverted.getDate(_currentDay);
                  final res = await DioProvider().storeAvailability(
                      getDate,
                      _startTime.toString(),
                      _endTime.toString(),
                      doctor['doctor_id']);
                  // redirect to doctor home page upon 201 status code
                  if (res == 201) {
                    MyApp.navigatorKey.currentState!.pushNamed('/dr_home');
                  }
                },
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}
