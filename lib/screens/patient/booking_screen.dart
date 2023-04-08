import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mydoc/components/button.dart';
import 'package:mydoc/components/custom_appbar.dart';
import 'package:mydoc/models/booking_datetime_converted.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:mydoc/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mydoc/utils/flash_message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range_picker/time_range_picker.dart';

var unavailableDate, patient;

void fetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  patient = await json.decode(prefs.get('patient') as String);
}

void fetchAvailability(id) async {
  unavailableDate = await DioProvider().getAvailability(id);
}

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _dateSelected = true;
  bool _timeSelected = false;
  TimeOfDay? time;

  Future displayTimePicker(BuildContext context) async {
    // convert to TimeOfDay to int
    int convertTimeOfDay(TimeOfDay time) => time.hour * 60 + time.minute;

    time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    int selectedTime = time!.hour * 60 + time!.minute;
    DateTime date = DateTime.parse(unavailableDate['available_date']);

    var startTime =
        TimeOfDay.fromDateTime(DateTime.parse(unavailableDate['start_time']));
    int _startTime = convertTimeOfDay(startTime);

    var endTime =
        TimeOfDay.fromDateTime(DateTime.parse(unavailableDate['end_time']));
    int _endTime = convertTimeOfDay(endTime);

    // check if unavailable time is selected
    if (_currentDay.year == date.year &&
        _currentDay.month == date.month &&
        _currentDay.day == date.day) {
      if (selectedTime > _startTime && selectedTime < _endTime) {
        _timeSelected = false;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: CustomSnackBar(
              errorText: 'Selected time is not available currently.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }
    } else {
      _timeSelected = true;
    }
  }

  Future<void> appointmentHandler(context, patient, doctor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //convert date/day/time into string first
    final getDate = DateConverted.getDate(_currentDay);
    final getTime = '${time!.hour}:00';

    final res = await DioProvider().bookAppointment(
        patient['patient_id'], getDate, getTime, doctor['doctor_id']);

    if (res['error'] == 'false') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/successBooked');
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    fetchData();
    fetchAvailability(doctor['doctor_id']);
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Appointment',
        icon: FaIcon(Icons.arrow_back_ios_new),
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
          SliverToBoxAdapter(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Button(
              width: double.infinity,
              title: 'Select Consultation Time',
              onPressed: () async {
                displayTimePicker(context);
              },
              disable: _dateSelected ? false : true,
            ),
          )),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () => appointmentHandler(context, patient, doctor),
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
            BoxDecoration(color: Color(0xFF7165D6), shape: BoxShape.circle),
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
            _dateSelected = false;

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: CustomSnackBar(errorText: 'Weekend is not available'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ));
          } else {
            _dateSelected = true;
          }
        });
      }),
    );
  }
}
