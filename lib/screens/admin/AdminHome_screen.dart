import 'package:flutter/material.dart';
import 'package:mydoc/screens/doctor/settings_screen.dart';

import '../../providers/dio_provider.dart';
import 'add_doctor.dart';
import 'doctor_profile.dart';

final String _profileImageURL = 'images/doctor3.jpg';

List imgs = [
    "doctor4.jpg",
    "doctor3.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];
  
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Hello Admin",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/admin.jpg"),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "List of Doctors",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 32),
          DoctorsBuilder(),
          const SizedBox(height: 32),
          Center(
            child: FloatingActionButton.extended(
              label: Text('Add new Doctor'),
              backgroundColor: const Color(0xFF7165D6),
              icon: Icon(
                Icons.person_add_sharp,
                size: 24.0,
              ),
              
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddNewDoctor(),
                    ));
              },
            ),
          ),
        ],
      )),
    );
  }
}

class DoctorsBuilder extends StatelessWidget {
  const DoctorsBuilder({super.key});

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
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DrProfileDetailsScreen(doctor: doctor),
                    ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage:AssetImage("images/${imgs[index]}"),
                                //fetchImage(snapshot.data[index]['image']),
                                //NetworkImage(_profileImageURL),
                          ),
                          Text(
                            "Dr. ${snapshot.data[index]['full_name']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "${snapshot.data[index]['qualifications']}",
                            style: const TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }
}
