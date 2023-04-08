import 'package:flutter/material.dart';
import 'package:mydoc/providers/dio_provider.dart';

Future<void> logoutHandler(context) async {
  var res = await DioProvider().logout();
  // TODO prompt "logout successful"
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
}

//ImageProvider<Object> fetchImage(image) {}
