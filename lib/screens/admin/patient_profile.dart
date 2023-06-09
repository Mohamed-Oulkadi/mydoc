import 'package:flutter/material.dart';

class PatientProfDetails extends StatelessWidget {
  const PatientProfDetails({super.key, required this.patient});

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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textfield(
                      hintText: "${patient['full_name']}",
                      prefixIcon: const Icon(Icons.person),
                    ),
                    textfield(
                      hintText: "${patient['email']}",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    textfield(
                      hintText: "${patient['phone_number']}",
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    textfield(
                      hintText: "${patient['id_card']}",
                      prefixIcon: const Icon(Icons.badge),
                    ),
                    textfield(
                      hintText: "${patient['birthday']}",
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ),
              Center(
            child: FloatingActionButton.extended(
              label: Text('Delete'),
              backgroundColor: Color.fromARGB(255, 218, 51, 51),
              icon: Icon(
                Icons.delete_rounded,
                size: 24.0,
              ),
              onPressed: () {
                
              },
            ),
          ),
            ],
          ),
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
      ..relativeLineTo(0, 120)
      ..quadraticBezierTo(size.width / 2, 150, size.width, 100)
      ..relativeLineTo(0, -120)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
