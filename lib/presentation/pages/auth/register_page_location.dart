import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/widgets/my_text_field.dart';

class RegisterPageLocation extends StatefulWidget {
  const RegisterPageLocation({super.key});

  @override
  State<RegisterPageLocation> createState() => _RegisterPageLocationState();
}

class _RegisterPageLocationState extends State<RegisterPageLocation> {
  bool value = false;

  void onChanged(bool? newValue) {
    setState(() {
      value = newValue ?? false;
    });
  }

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
                    label: 'Contact No.',
                    icon: Icon(Icons.phone),
                  ),
                  const SizedBox(height: 8),
                  const MyTextField(
                    label: 'Address',
                    icon: Icon(Icons.location_on),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(
                          width: 1.5,
                          color: Color(
                            0xFF023E8A,
                          ),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: value,
                        onChanged: onChanged,
                        activeColor: const Color(0xFF023E8A),
                      ),
                      Text(
                        'I agree to the Terms and Conditions',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: const Color(0xCC3B3B3B),
                        ),
                      )
                    ],
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
                        backgroundColor: const Color(0xFF023E8A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Register',
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
          )
        ],
      )),
    );
  }
}
