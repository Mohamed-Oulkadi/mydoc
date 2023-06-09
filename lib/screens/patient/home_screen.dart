import 'package:flutter/material.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:mydoc/providers/common.dart';

import '../../utils/config.dart';
final String _profileImageURL = 'images/doctor1.jpg';
List imgs = [
    "doctor4.jpg",
    "doctor3.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Header(),
            SizedBox(height: 30),
            _TwoGiantButtons(),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Available Doctors",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            DoctorsBuilder(),
          ],
        )));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

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
            var fullName = snapshot.data['full_name'];
            return Row(
              children: [
                Text(
                  "Hello ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$fullName",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("images/patient.jpg"),
                  ),
              ],
            );
          }
        });
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
                    onTap: () => Navigator.pushNamed(context, '/appointments'),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 5),
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
                            //backgroundImage: snapshot.data[index]['image'],
                            backgroundImage: AssetImage("images/${imgs[index]}"),
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
                          Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            )
                          ],
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

class _TwoGiantButtons extends StatelessWidget {
  const _TwoGiantButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            // TODO send to appointment page
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 4,
                    )
                  ]),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFF7165D6),
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: const Text(
                        "Clinic Visit",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: const Text(
                        "Make an appointment",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}













