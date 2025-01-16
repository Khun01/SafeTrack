import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

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
                'Reset Password',
                style: GoogleFonts.nunito(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B3B3B),
                ),
              ),
              Text(
                'Enter your new password to open your account',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0x803B3B3B),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Create your new password to secure your account and get back on track. Make it strong, unique, and ready to keep your data safe!',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0x803B3B3B),
                ),
              ),
              const SizedBox(height: 16),
              MyForm(
                label: 'Password',
                icon: const Icon(Icons.lock_outline),
                obscureText: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              MyForm(
                label: 'Confirm Password',
                icon: const Icon(Icons.lock_outline),
                obscureText: true,
                onChanged: (value) {},
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
                        builder: (context) => const LoginPage(),
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
                    'Reset Password',
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
