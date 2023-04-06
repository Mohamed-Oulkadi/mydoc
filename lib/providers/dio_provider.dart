import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  static final _dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000',
    responseType: ResponseType.json,
    validateStatus: (_) => true,
    contentType: Headers.jsonContentType,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
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
      String roleString = response.data['user']['role'];
      await prefs.setString(roleString, json.encode(response.data[roleString]));
    }
    return response.data;
  }

  // upload image
  Future uploadImage(image, userId) async {
    Uint8List imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await _dio.patch('/api/user/$userId',
        data: {'image': base64Image},
        options: Options(
            headers: {'Authorization': 'Bearer ${prefs.get("token")}'}));

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
  Future updateUser(id, [email, password, image]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {};

    if (!image) {
      data = {'email': email, 'password': password};
    } else {
      // TODO if an admin wants to change an image, handle it properly
      data = {'email': email, 'password': password, 'image': image};
    }

    var response = await _dio.patch('/api/user/$id',
        data: data,
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
  Future updateDoctor(id,
      [fullName, phoneNumber, description, qualifications]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {};

    if (!fullName) {
      data.addAll({'full_name': fullName});
    }
    if (!phoneNumber) {
      data.addAll({'phone_number': phoneNumber});
    }
    if (!description) {
      data.addAll({'description': description});
    }
    if (!qualifications) {
      data.addAll({'qualifications': qualifications});
    }

    var response = await _dio.patch("/api/doctors/$id",
        data: data,
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
  Future registerUser(String fullname, String email, String phonenumber,
      String idcard, String birthday, String password, String password2) async {
    var user = await _dio.post('/api/register', data: {
      'full_name': fullname,
      'email': email,
      'phone_number': phonenumber,
      'id_card': idcard,
      'birthday': birthday,
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
  Future updatePatient(patientId,
      [fullName, phoneNumber, idCard, city, birthday]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {};
    if (!fullName) {
      data.addAll({'full_name': fullName});
    }
    if (!phoneNumber) {
      data.addAll({'phone_number': phoneNumber});
    }
    if (!idCard) {
      data.addAll({'id_card': idCard});
    }
    if (!city) {
      data.addAll({'city': city});
    }
    if (!birthday) {
      data.addAll({'birthday': birthday});
    }
    var response = await _dio.patch("/api/patients/$patientId",
        data: data,
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
  Future bookAppointment(String date, String time, int doctorId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.post('/api/appointments',
        data: {
          'appointment_date': date,
          'appointment_time': time,
          'doctor_id': doctorId
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // update appointment details
  Future updateAppointment(appointmentId, doctorId, [date, day, time]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.patch('/api/appointments/$appointmentId',
        data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctorId},
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // delete appointment
  Future deleteAppointment(appointmentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.delete('/api/appointments/$appointmentId',
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
    var response = await _dio.post('/api/reviews',
        data: {
          'ratings': ratings,
          'reviews': reviews,
          'appointment_id': id,
          'doctor_id': doctorId
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }

  // delete specefic review
  Future deleteReview(reviewId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.delete('/api/reviews/$reviewId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }

  // retrieve all reviews
  Future getReviews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.delete('/api/reviews',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }

  // get specifc review
  Future getReview(reviewId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.delete('/api/reviews/$reviewId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

 // store availability date
  Future storeAvailability(
      String date, String start_time, String end_time, int doctor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.post('/api/availabilities',
        data: {
          'doctor_id': doctor,
          'unavailable_date': date,
          'start_time': start_time,
          'end_time': end_time
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 201 && response.data != '') {
      return response.statusCode;
    } else {
      return 'Error';
    }
  }

  // get specific availability
  Future getAvailability(availabilityId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.get('/api/availability/$availabilityId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  // get all messages related to the current user
  Future getMessages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    var response = await _dio.get('/api/chat',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    prefs.setString('messages', json.encode(response.data['messsages']));

    return response.data;
  }

  // send a message to a specific user
  Future sendMessage(receiverId, message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');

    var response = await _dio.post('/api/chat',
        data: {'receiver_id': receiverId, 'message': message},
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return response.data;
  }

  Future fetchCurrentUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await json.decode(prefs.getString('user') as String);
  }

  Future fetchCurrentDoctorData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await json.decode(prefs.getString('doctor') as String);
  }

  Future fetchCurrentPatientData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await json.decode(prefs.getString('patient') as String);
  }
}
