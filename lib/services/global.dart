import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String baseUrl = 'http://192.168.100.212:8000/api';
const String profileUrl = 'http://192.168.100.212:8000/';

void toast(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: const Color(0xFF3B3B3B),
    textColor: const Color(0xFFFCFCFC),
    fontSize: 16.0,
  );
}