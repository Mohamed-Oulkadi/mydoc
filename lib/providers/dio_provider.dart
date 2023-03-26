import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  static final _dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000',
    responseType: ResponseType.json,
    validateStatus: (_) => true,
    contentType: Headers.jsonContentType,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  // login
  Future login(String email, String password) async {
    var response = await _dio.post('/api/login',
        data: json.encode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token', response.data['Authorization'].toString().split(' ')[1]);
      await prefs.setString('user', json.encode(response.data['user']));
    }

    return response.data;
  }

  // get specfic user data
  Future getUser(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.get("/api/users/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    prefs.setString('user', json.encode(response.data));
    return response.data;
  }

  // get all users data
  Future getUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.get('/api/users',
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    prefs.setString('doctors', json.encode(response.data));
    return response.data;
  }

  // update specific user data
  Future updateUser(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.patch('/api/user/$id',
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

  // delete specific user data
  Future deleteUser(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.delete('/api/user/$id',
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

  // get all doctors data
  Future getDoctors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.get('/api/doctors',
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    await prefs.setString('doctors', json.encode(response.data));
    return response.data;
  }

  // get specific doctor data
  Future getDoctor(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.get("/api/doctors/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

  // update specific doctor data
  Future updateDoctor(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.patch("/api/doctors/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

  // delete specific doctor data
  Future deleteDoctor(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.delete("/api/doctors/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

  // register new user
  Future registerUser(String username, String email, String phonenumber,
      String password, String password2) async {
    var user = await _dio.post('/api/register', data: {
      'fullname': username,
      'email': email,
      'phone_number': phonenumber,
      'password': password,
      'password_confirmation': password2
    });

    return user.data;
  }

// get all patients data
  Future getPatients() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _dio.get("/api/patients",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

// get specific patient data
  Future getPatient(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _dio.get("/api/patients/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

// update specific patient data
  Future updatePatient(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _dio.patch("/api/patients/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

// delete specific patient
  Future deletePatient(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _dio.delete("/api/patients/$id",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

// get current patient data
  Future getCurrentPatient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = json.decode(prefs.getString('user')!);
    var response = await _dio.get("/api/patients/${user['id']}",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    await prefs.setString('patient', json.encode(response.data));
    return response.data;
  }

  // get current patient data
  Future getCurrentDoctor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = json.decode(prefs.getString('user')!);
    var response = await _dio.get("/api/doctor/${user['id']}",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    await prefs.setString('patient', json.encode(response.data));
    return response.data;
  }

  // retrieve all appointments
  Future getAppointments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.get('/api/appointments',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // retrieve specific appointments
  Future getAppointment(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.get('/api/appointments/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  //store appointment details
  Future bookAppointment(
      String date, String day, String time, int doctorId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.post('/api/appointments',
        data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctorId},
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // update appointment details
  Future updateAppointment(
      String date, String day, String time, int doctorId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await Dio().patch('/api/appointments',
        data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctorId},
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // delete appointment
  Future deleteAppointment(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await Dio().delete('/api/appointments/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

// logout
  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.post('/api/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // store rating details
  Future storeReviews(
      String reviews, double ratings, int id, int doctorId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await Dio().post('/api/reviews',
        data: {
          'ratings': ratings,
          'reviews': reviews,
          'appointment_id': id,
          'doctor_id': doctorId
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }
}

// delete specefic review
Future deleteReview(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('token');
  var response = await Dio().delete('/api/reviews/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}));
  return response.data;
}

// retrieve all reviews
Future getReviews() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('token');
  var response = await Dio().delete('/api/reviews',
      options: Options(headers: {'Authorization': 'Bearer $token'}));
  return response.data;
}

// get specifc review
Future getReview(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('token');
  var response = await Dio().delete('/api/reviews/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}));

  return response.data;
}

// store availability date
Future storeAvailability(
    String date, String day, String time, int doctor, String token) async {
  var response = await Dio().post('/api/availability',
      data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctor},
      options: Options(headers: {'Authorization': 'Bearer $token'}));

  if (response.statusCode == 200 && response.data != '') {
    return response.statusCode;
  } else {
    return 'Error';
  }
}

// get availability date
Future getAvailability(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('token');
  var response = await Dio().get('/api/availability/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}));

  return response.data;
}
