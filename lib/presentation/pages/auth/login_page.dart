import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/auth/forgot_password_page.dart';
import 'package:safetrack/presentation/pages/auth/register_page.dart';
import 'package:safetrack/presentation/pages/wrapper.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                'Welcome',
                style: GoogleFonts.nunito(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B3B3B),
                ),
              ),
              Text(
                'Please sign in to your Account',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0x803B3B3B),
                ),
              ),
              const SizedBox(height: 24),
              const MyForm(
                label: 'Email',
                icon: Icon(Icons.mail_outline),
              ),
              const SizedBox(height: 8),
              const MyForm(
                label: 'Password',
                icon: Icon(Icons.lock_outline),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: const Color(0xCC3B3B3B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Wrapper(),
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
                          'Login',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFCFCFC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: const BorderSide(
                                color: Color(0xFF023E8A),
                              ),
                            ),
                            elevation: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/google.png',
                              height: 25,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Sign in using Google',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: const Color(0xCC3B3B3B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: Text(
                      'Register Now',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: const Color(0xFF023E8A),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF023E8A),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
