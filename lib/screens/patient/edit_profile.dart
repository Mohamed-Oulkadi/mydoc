import 'dart:io';

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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final String _profileImageURL = 'images/doctor1.jpg';

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
    _ageController.dispose();
    _birthdayController.dispose();
    _cinController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final patient = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                      pickImage();
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
                        suffixIcon: Icon(Icons.edit), 
                      ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthdayController,
                      readOnly: true,
                      validator: (value) => validateBirthdayDate(value),
                      decoration: const InputDecoration(
                        labelText: "Birthday Date",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                        suffixIcon: Icon(Icons.edit), 
                      ),
                      onTap: () async {
                        var pickedDate = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime(1994),
                          firstDate: DateTime(1960),
                          lastDate: DateTime(2012),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.en_us,
                          looping: true,
                        );
                        if (pickedDate != null) {
                          _birthdayController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cinController,
                      validator: (value) => validateIdCard(value),
                      decoration: const InputDecoration(
                        labelText: "CIN",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                        suffixIcon: Icon(Icons.edit), 
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
                        suffixIcon: Icon(Icons.edit), 
                      ),
                    ),
              const SizedBox(height: 32),
              Center(
            child: FloatingActionButton.extended(
              label: Text('Update'),
              backgroundColor: Color.fromARGB(255, 28, 151, 38),
              icon: Icon(
                Icons.update_sharp,
                size: 24.0,
              ),
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                      final res = await DioProvider().updateDoctor(
                          _nameController.text,
                          _phoneController.text,
                          _cinController.text,
                          _birthdayController.text,
                          patient['patient_id']);

                      // redirect to home page upon 200 status code
                      if (res == 201) {
                        MyApp.navigatorKey.currentState!
                            .pushNamed('/patient_profile');
                      }
                    }
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
