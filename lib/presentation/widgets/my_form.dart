import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyForm extends StatefulWidget {
  final String label;
  final Icon icon;
  final bool obscureText;

  const MyForm({
    super.key,
    required this.label,
    required this.icon,
    this.obscureText = false,
  });

  @override
  State<MyForm> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyForm> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3B3B3B),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelStyle: GoogleFonts.nunito(
              color: const Color(0xFF023E8A),
            ),
            fillColor: const Color(0xFFF0F0F0),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            prefixIcon: widget.icon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      widget.obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF3B3B3B),
                    ),
                    onPressed: _toggleObscureText,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
