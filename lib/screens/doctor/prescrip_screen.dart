import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../providers/dio_provider.dart';
import '../../utils/config.dart';


// ignore: camel_case_types
class newPresc extends StatefulWidget {
  @override
  _newPrescState createState() => _newPrescState();
}

// ignore: camel_case_types
class _newPrescState extends State<newPresc> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final saveKey = GlobalKey<FormState>();
    var _Sympt, _Diag, _Presc, _Adv;
    //var _sympt, _diag, _presc, _adv;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: saveKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Header(),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Sympt = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Symptoms",
                        prefixIcon: Icon(Icons.edit_outlined),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Diag = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Diagnosis",
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Presc = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Prescription",
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Adv = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Advice",
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(80, 10, 0, 0),
                        child: MaterialButton(
                          onPressed: () {
                            //TODO : Generate pdf
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFB40284A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Generate Pdf",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFFB40284A),
                            width: 1,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFB40284A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
            return SafeArea(
              minimum: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    "Medical Document For ",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$fullName",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
