import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyForm extends StatefulWidget {
  final String label;
  final Icon icon;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String> onChanged;

  const MyForm({
    super.key,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.errorText,
    required this.onChanged,
  });

  @override
  State<MyForm> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyForm> {
  final FocusNode _focusNode = FocusNode();
  late bool obscureText;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showError = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3B3B3B),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: _focusNode,
          obscureText: obscureText, // Use the state variable here
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelStyle: GoogleFonts.quicksand(
              color: const Color(0xFF023E8A),
            ),
            errorText: _showError ? widget.errorText : null,
            fillColor: const Color(0xFFF0F0F0),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
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
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF3B3B3B),
                    ),
                    onPressed:
                        _toggleObscureText,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
