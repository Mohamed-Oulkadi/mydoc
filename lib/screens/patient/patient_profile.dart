import 'package:flutter/material.dart';

import '../../providers/dio_provider.dart';
import '../../utils/config.dart';

class PatientProfileDetails extends StatelessWidget {
  const PatientProfileDetails({super.key, required this.patient});

  final Map<dynamic, dynamic> patient;

  Widget textfield({@required hintText, @required prefixIcon}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF7165D6),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/edit_profile',
                    arguments: {"patient_id": patient['patient_id']}),
                child: const Icon(Icons.edit),
              ))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PatientProf(),
          CustomPaint(
            painter: HeaderCurvedContainer(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/patient.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF7165D6);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PatientProf extends StatelessWidget {
  const PatientProf({
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 450,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              //prefixIcon: prefixIcon,
                              hintText: "${snapshot.data['full_name']}",
                              hintStyle: const TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white30,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              //prefixIcon: prefixIcon,
                              hintText: "${snapshot.data['id_card']}",
                              hintStyle: const TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white30,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              //prefixIcon: prefixIcon,
                              hintText: "1990-4-23",
                              hintStyle: const TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white30,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              //prefixIcon: prefixIcon,
                              hintText: "${snapshot.data['full_name']}@gmail.com",
                              hintStyle: const TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white30,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      Material(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              //prefixIcon: prefixIcon,
                              hintText: "${snapshot.data['phone_number']}",
                              hintStyle: const TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white30,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      /* textfield(
                        hintText: "${patient['full_name']}",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      textfield(
                        hintText: "Amina@gmail.com", //"${patient['email']}",
                        prefixIcon: const Icon(Icons.email),
                      ),
                      textfield(
                        hintText: "0667876545", //"${patient['phone_number']}",
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      textfield(
                        hintText: "JM142356", //"${patient['id_card']}",
                        prefixIcon: const Icon(Icons.badge),
                      ),
                      textfield(
                        hintText: "1990-5-2", //"${patient['birthday']}",
                        prefixIcon: const Icon(Icons.calendar_today),
                      ), */
                    ],
                  ),
                )
              ],
            );
          }
        });
  }
}
