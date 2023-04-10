import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydoc/providers/common.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:mydoc/screens/patient/patient_profile.dart';

import '../../utils/config.dart';

Map<String, dynamic> patient = {};

void fetchData() async {
  patient = await DioProvider().fetchCurrentPatientData();
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            const PatientName(),
            const Divider(height: 50),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientProfileDetails(patient: patient),
                    ));
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              title: const Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.deepPurple,
                  size: 35,
                ),
              ),
              title: const Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.indigo,
                  size: 35,
                ),
              ),
              title: const Text(
                "Privacy",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.orange,
                  size: 35,
                ),
              ),
              title: const Text(
                "About Us",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const Divider(height: 40),
            ListTile(
              onTap: () => logoutHandler(context),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 35,
                ),
              ),
              title: const Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientName extends StatelessWidget {
  const PatientName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return FutureBuilder(
        future: DioProvider().fetchCurrentPatientData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("images/patient.jpg"),
              ),
              title: Text(
                "${snapshot.data['full_name']}",
                //"Amina",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              subtitle: const Text("Patient"),
            );
          }
        });
  }
}
