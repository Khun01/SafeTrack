import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyVerificationForm extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final String hintText;
  final TextInputType keyboardType;
  const MyVerificationForm({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        onChanged: (value) => onChanged(),
        keyboardType: keyboardType,
        style: GoogleFonts.quicksand(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF3B3B3B),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.only(
            left: 12,
            top: 0,
            bottom: 0,
            right: 12,
          ),
          hintStyle: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0x333B3B3B),
          ),
          fillColor: const Color(0x1A023E8A),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
