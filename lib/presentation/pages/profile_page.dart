import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_event.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_state.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/pages/profile_information_page.dart';
import 'package:safetrack/presentation/pages/verify_account_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    final LogoutBloc logoutBloc =
        LogoutBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => logoutBloc,
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccessfully) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false);
          } else if (state is LogoutFailed) {
            toast(context, state.error);
            log('THe error in logging out is: ${state.error}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Profile',
                          style: GoogleFonts.quicksand(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: Colors.yellow,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Brandon Lambino',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                                Text(
                                  'Not verified yet',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    color: const Color(0xFF3B3B3B),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0x1A3B3B3B)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Account',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    color: const Color(0x803B3B3B),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 2,
                                color: Color(0x1A3B3B3B),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileInformationPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    left: 10,
                                    right: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: Color(0x803B3B3B),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Profile information',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF3B3B3B),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0x803B3B3B),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 2,
                                color: Color(0x1A3B3B3B),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VerifyAccountPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    left: 10,
                                    right: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle_outline,
                                        color: Color(0x803B3B3B),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Verify your account',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF3B3B3B),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0x803B3B3B),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0x1A3B3B3B)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Settings',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    color: const Color(0x803B3B3B),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 2,
                                color: Color(0x1A3B3B3B),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 10,
                                  right: 12,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.notifications_none,
                                      color: Color(0x803B3B3B),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Notification',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF3B3B3B),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 10,
                                      child: Transform.scale(
                                        scale: .9,
                                        child: Switch(
                                          value: isToggled,
                                          onChanged: (bool value) {
                                            setState(() {
                                              isToggled = value;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 2,
                                color: Color(0x1A3B3B3B),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 10,
                                  right: 12,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<LogoutBloc>()
                                        .add(LogoutButtonClickedEvent());
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.logout,
                                        color: Color(0x803B3B3B),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Logout',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 14,
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
                      ],
                    ),
                  ),
                  if (state is LogoutLoading) ...[
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
