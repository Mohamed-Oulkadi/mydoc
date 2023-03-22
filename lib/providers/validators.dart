import 'package:validators/validators.dart';

String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }

  RegExp regExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!regExp.hasMatch(value)) {
    return 'Please enter valid full name (alphanumeric only)';
  }

  if (value.length < 5) {
    return 'full name length too short';
  }

  if (value.allMatches(" ").length == 2) {
    return 'Name too long';
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return !isEmail(value) ? "Invalid Email" : null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }

  if (value.length < 8) {
    return 'Password length should be of a minimum of 8 characters';
  }

  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || !isNumeric(value)) {
    return "Invalid phone number";
  }

  if (!value.startsWith('06')) {
    return 'Not a valid moroccan phone number';
  }

  if (value.length != 10) {
    return 'Mobile Number must be of 10 digit';
  }

  return null;
}
