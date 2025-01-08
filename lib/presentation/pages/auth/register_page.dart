import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/auth/register_page_location.dart';
import 'package:safetrack/presentation/widgets/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
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
                      color: Color(0xFFFCFCFC),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Create Account',
                    style: GoogleFonts.nunito(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFCFCFC),
                    ),
                  ),
                  Text(
                    'Please fill in the form to continue',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xCCFCFCFC),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.nunito(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF023E8A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const MyTextField(
                    label: 'Name',
                    icon: Icon(Icons.person),
                  ),
                  const SizedBox(height: 8),
                  const MyTextField(
                    label: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  const SizedBox(height: 8),
                  const MyTextField(
                    label: 'Password',
                    icon: Icon(Icons.lock),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  const MyTextField(
                    label: 'Confirm Password',
                    icon: Icon(Icons.lock),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPageLocation(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF023E8A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFCFCFC),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFC2C2C2),
                          height: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Or Continue With',
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xCC3B3B3B)),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFC2C2C2),
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xCC3B3B3B),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/icons/google.png',
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xCC3B3B3B),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/icons/facebook.png',
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xCC3B3B3B),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Sign In',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color(0xFF023E8A),
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFF023E8A),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
