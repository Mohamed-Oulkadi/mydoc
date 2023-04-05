import 'package:flutter/material.dart';
import 'package:mydoc/providers/utils.dart';
import 'package:mydoc/providers/dio_provider.dart';

import '../../utils/config.dart';

class HomeScreen extends StatelessWidget {
  final List __symptoms = [
    "Temperature",
    "Snuffle",
    "Fever",
    "Caugh",
    "Cold",
  ];

  final List _imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: 30),
            const _TwoGiantButtons(),
            const SizedBox(height: 25),
            const SymptomsBar(),
            SizedBox(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: __symptoms.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        __symptoms[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Popular Doctors",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            DoctorsBuilder(imgs: _imgs),
          ],
        )));
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final patient = ModalRoute.of(context)!.settings.arguments as Map;
    return FutureBuilder(
        future: DioProvider().getPatient(patient['patient_id']),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var fullName = snapshot.data['full_name'];
            return Text(
              "Hello $fullName",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            );
          }
        });
  }
}

class DoctorsBuilder extends StatelessWidget {
  const DoctorsBuilder({
    super.key,
    required List imgs,
  }) : _imgs = imgs;

  final List _imgs;

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
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => showScreen(context, '/appointments'),
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
                            backgroundImage:
                                AssetImage("images/${_imgs[index]}"),
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
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                "${snapshot.data[index]['rating']}",
                                style: const TextStyle(
                                  color: Colors.black45,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }
}

class SymptomsBar extends StatelessWidget {
  const SymptomsBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "What are your symptoms?",
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }
}

class _TwoGiantButtons extends StatelessWidget {
  const _TwoGiantButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                const SizedBox(height: 30),
                const Text(
                  "Clinic Visit",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Make an appointment",
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
