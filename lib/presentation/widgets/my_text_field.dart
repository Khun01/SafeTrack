import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final Icon icon;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.label,
    required this.icon,
    this.obscureText = false,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: GoogleFonts.nunito(
          color: const Color(0xFF023E8A),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF023E8A),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF023E8A),
            width: 1,
          ),
        ),
        prefixIcon: widget.icon,
        prefixIconColor: const Color(0xFF023E8A),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  widget.obscureText ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF023E8A),
                ),
                onPressed: _toggleObscureText,
              )
            : null,
      ),
    );
  }
}
