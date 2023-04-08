import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mydoc/providers/validators.dart';

import '../../main.dart';
import '../../providers/dio_provider.dart';
import '../../utils/config.dart';

class AddNewDoctor extends StatefulWidget {
  const AddNewDoctor({Key? key}) : super(key: key);

  @override
  AddNewDoctorState createState() => AddNewDoctorState();
}

class AddNewDoctorState extends State<AddNewDoctor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _profileImageURL = 'images/doctor1.jpg';

  bool _passToggle = true;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Config().init(context);
    //final patient = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Doctor'),
        backgroundColor: const Color(0xFF7165D6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF7165D6),
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageURL),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      //pickImage();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                validator: (value) => validateFullName(value),
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) => validateEmail(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                validator: (value) => validatePhoneNumber(value),
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                validator: (value) => validateFullName(value),
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                validator: (value) => validateFullName(value),
                decoration: const InputDecoration(
                  labelText: "Clinic Adress",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                validator: (value) => validateFullName(value),
                decoration: const InputDecoration(
                  labelText: "Qualifications",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                validator: (value) => validatePassword(value),
                obscureText: _passToggle,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (_passToggle == true) {
                        _passToggle = false;
                      } else {
                        _passToggle = true;
                      }
                      setState(() {});
                    },
                    child: Icon(
                      _passToggle
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
            child: FloatingActionButton.extended(
              label: Text('Add'),
              backgroundColor: Color.fromARGB(255, 14, 71, 228),
              icon: Icon(
                Icons.person_add,
                size: 24.0,
              ),
              onPressed: () async{
                /* if (_formKey.currentState!.validate()) {
                      final res = await DioProvider().updateDoctor(
                          _nameController.text,
                          _phoneController.text,
                          );

                      // redirect to home page upon 200 status code
                      if (res == 201) {
                        MyApp.navigatorKey.currentState!
                            .pushNamed('/patient_profile');
                      }
                    } */
              },
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
