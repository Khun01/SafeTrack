import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 32, left: 16, bottom: 24),
                decoration: const BoxDecoration(
                  color: Color(0xFF023E8A),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFFFCFCFC),
                    ),
                    const Spacer(),
                    Text(
                      'Create Account',
                      style: GoogleFonts.nunito(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFCFCFC)
                      ),
                    ),
                    Text(
                      'Please fill in the form to continue',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xCCFCFCFC)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    Text(
                      'Register',
                      style: GoogleFonts.nunito(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023E8A),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}