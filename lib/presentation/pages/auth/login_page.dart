import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_event.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_state.dart';
import 'package:safetrack/presentation/pages/auth/forgot_password_page.dart';
import 'package:safetrack/presentation/pages/auth/register_page.dart';
import 'package:safetrack/presentation/pages/wrapper.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc =
        LoginBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginFailed) {
            log('Ngek error');
            toast(context, state.errorMessage);
          } else if (state.loginSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wrapper()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
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
                        MyForm(
                          label: 'Email',
                          icon: const Icon(Icons.mail_outline),
                          errorText: !state.emailIsNotEmpty
                              ? 'Enter your email'
                              : (!state.isEmailValid ? 'Invalid email' : null),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(LoginEmailChanged(email: value));
                          },
                        ),
                        const SizedBox(height: 8),
                        MyForm(
                          label: 'Password',
                          icon: const Icon(Icons.lock_outline),
                          errorText: !state.passwordIsNotEmpty
                              ? 'Enter your password'
                              : (!state.isPasswordValid
                                  ? 'Password should be greater than 6'
                                  : null),
                          obscureText: true,
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(LoginPasswordChanged(password: value));
                          },
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage()));
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
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginButtonPressed());
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
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
                                        builder: (context) =>
                                            const RegisterPage()));
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
                  if (state.loginLoading) ...[
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const Center(
                      child: MyCircularProgressIndicator(),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
