import 'package:flutter/material.dart';
import 'package:mydoc/providers/validators.dart';

class AddNewDoctor extends StatefulWidget {
  const AddNewDoctor({Key? key}) : super(key: key);

  @override
  AddNewDoctorState createState() => AddNewDoctorState();
}

class AddNewDoctorState extends State<AddNewDoctor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _idCardNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final String _profileImageURL = 'images/doctor1.jpg';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _birthdayController.dispose();
    _idCardNumberController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageURL),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: Implement photo selection
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (value) => validateFullName(value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthdayController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                validator: (value) {
                  // TODO proper birthday validation
                  // (to add in providers/validators.dart)
                  if (value == null || value.isEmpty) {
                    return 'Please enter your City';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idCardNumberController,
                decoration: const InputDecoration(
                  labelText: 'qualifications',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement profile update
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
