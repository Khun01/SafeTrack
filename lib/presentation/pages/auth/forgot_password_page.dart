import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/auth/verification_page.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Color(0xFF3B3B3B),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Forgot Password',
                style: GoogleFonts.nunito(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B3B3B),
                ),
              ),
              Text(
                'Please enter your email address',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0x803B3B3B),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Enter the verification code sent to your email to reset your password.',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0x803B3B3B),
                ),
              ),
              const SizedBox(height: 16),
              const MyForm(
                label: 'Email',
                icon: Icon(Icons.mail_outline),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF023E8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Forgot Password',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFCFCFC),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
