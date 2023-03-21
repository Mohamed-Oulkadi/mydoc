import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  static BaseOptions opts = BaseOptions(
    baseUrl: 'http://127.0.0.1:8000',
    responseType: ResponseType.json,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  );

  static final _dio = Dio(opts);

  dynamic requestInterceptor(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");

    options.headers.addAll({"Authorization": "bearer $token"});

    return options;
  }

  // login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var response = await _dio.post('/api/login',
          data: json.encode({'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'token', response.headers['authorization'].toString());
      }
      return response.data;
    } on DioError catch (e) {
      return {'error': e.message};
    }
  }

  // get user data
  Future<Map<String, dynamic>> getUser(String token) async {
    try {
      var response = await _dio.get('/api/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (error) {
      return {'error': error.toString()};
    }
  }

  // register new user
  Future<dynamic> registerUser(
      String username, String email, String password, String password2) async {
    try {
      var user = await _dio.post('/api/register', data: {
        'name': username,
        'email': email,
        'password': password,
        'password2': password2
      });
      if (user.statusCode == 201) {
        return user.data;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  // store booking details
  Future<dynamic> bookAppointment(
      String date, String day, String time, int doctor, String token) async {
    try {
      var response = await _dio.post('/api/book',
          data: {'date': date, 'time': time, 'doctor_id': doctor},
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

  // retrieve booking details
  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await _dio.get('/api/appointments',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  // store rating details
  Future<dynamic> storeReviews(
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

  // store fav doctor
  Future<dynamic> storeFavDoc(String token, List<dynamic> favList) async {
    try {
      var response = await _dio.post('/api/fav',
          data: {
            'favList': favList,
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

// logout
  Future<dynamic> logout(String token) async {
    try {
      var response = await _dio.post('/api/logout',
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
}
