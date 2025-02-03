import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/theme/colors.dart';

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

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.quicksand(
          fontSize: 14,
          color: LightColor.whitePrimaryTextColor,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: LightColor.primaryColor,
      behavior: SnackBarBehavior.fixed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(26),
        ),
      ),
      padding: const EdgeInsets.all(16),
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
