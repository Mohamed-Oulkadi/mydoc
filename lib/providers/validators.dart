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
    return 'Full name length is too short';
  }

  if (value.allMatches(" ").length > 3) {
    return 'Full name length is too long';
  }

  if (!value.contains(" ")) {
    return 'Not a valid full name';
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

  if (!value.startsWith('06') && !value.startsWith('07')) {
    return 'Not a valid moroccan phone number';
  }

  if (value.length != 10) {
    return 'Mobile Number must be of 10 digit';
  }

  return null;
}

String? validateIdCard(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }

  RegExp regExp = RegExp(r'^[A-Za-z]{2}\d+$');
  if (!regExp.hasMatch(value)) {
    return 'Not a valid moroccan CIN';
  }
  return null;
}

String? validateBirthdayDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }

  DateTime? date;
  try {
    date = DateTime.parse(value);
  } catch (e) {
    return 'Please enter a valid date (yyyy-mm-dd)';
  }

  if (date.isAfter(DateTime.now())) {
    return 'Please enter a date that is not in the future';
  }

  if (DateTime.now().difference(date).inDays ~/ 365.25 < 18) {
    return 'You must be at least 18 years old';
  }

  return null;
}
