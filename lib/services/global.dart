// ignore_for_file: deprecated_member_use

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/theme/colors.dart';

const String baseUrl = 'http://192.168.100.212:8000/api';
const String evidenceUrl = 'http://192.168.100.212:8000/storage/';

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

void snackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            message,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              color: LightColor.whitePrimaryTextColor,
            ),
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

void navigationAnimation(
  BuildContext context,
  Widget page,
  SharedAxisTransitionType transitionType,
) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
    ),
  );
}

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  if (hex.length == 6) {
    hex = "FF$hex";
  }
  return Color(int.parse(hex, radix: 16)).withOpacity(1.0);
}
