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
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  // login
  Future login(String email, String password) async {
    var response = await _dio.post('/api/login',
        data: json.encode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token', response.data['Authorization'].toString().split(' ')[1]);
    }

    return response.data;
  }

  // get user data
  Future getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.get('/api/users',
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    prefs.setString('user', json.encode(response.data));
    return response.data;
  }

  // get all doctors data
  Future getDoctors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.get('/api/doctors',
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    prefs.setString('doctors', json.encode(response.data));
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

// get patient data
  Future getPatient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = json.decode(prefs.getString('user')!);
    var response = await _dio.get("/api/patients/${user['id']}",
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

    return response.data;
  }

  // store booking details
  Future bookAppointment(int doctorId, String date, String time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.post('/api/book',
        data: {
          'appointment_date': date,
          'appointment_time': time,
          'doctor_id': doctorId
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // retrieve all bookings
  Future getAppointments(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.get('/api/appointments',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // store rating details
  /*
  Future storeReviews(
      String reviews, double ratings, int id, int doctor, String token) async {
    try {
      var response = await _dio.post('/api/reviews',
          data: {
            'ratings': ratings,
            'reviews': reviews,
            'appointment_id': id,
            'doctor_id': doctor
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
  */

// logout
  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.post('/api/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }
}
