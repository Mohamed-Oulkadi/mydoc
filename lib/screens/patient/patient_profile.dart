import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile.dart';

var patient;

void fetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  patient = await json.decode(prefs.get('patient') as String);
}

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/doctor1.jpg'),
            ),
            const SizedBox(height: 20),
            const FullName(),
            const SizedBox(height: 10),
            const SizedBox(height: 5),
            BirthdayWidget(),
            const SizedBox(height: 5),
            const IdCardWidget(),
            const SizedBox(height: 5),
            const PhoneNumberWidget(),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ));
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DioProvider().getCurrentPatient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text(
              patient['phone_number'],
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            );
          }
        });
  }
}

class IdCardWidget extends StatelessWidget {
  const IdCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DioProvider().getCurrentPatient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text(
              patient['id_card'].toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            );
          }
        });
  }
}

class BirthdayWidget extends StatelessWidget {
  const BirthdayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DioProvider().getCurrentPatient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text(
              patient['birth_day'].toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            );
          }
        });
  }
}

class FullName extends StatelessWidget {
  const FullName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DioProvider().getDoctors(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text(
              patient['full_name'],
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            );
          }
        });
  }
}
