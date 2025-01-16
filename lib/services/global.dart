import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String baseUrl = 'http://192.168.100.212:8000/api';
const String profileUrl = 'http://192.168.100.212:8000/'; 

void toast(BuildContext context, String message){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0
  );
}