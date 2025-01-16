import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: GoogleFonts.nunito(
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
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      Text(
                        'Not verified yet',
                        style: GoogleFonts.nunito(
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
                        style: GoogleFonts.nunito(
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
                            Icons.person_outline,
                            color: Color(0x803B3B3B),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Profile information',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
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
                            Icons.check_circle_outline,
                            color: Color(0x803B3B3B),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Verify your account',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
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
                        style: GoogleFonts.nunito(
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
                            Icons.vpn_key_outlined,
                            color: Color(0x803B3B3B),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Change password',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
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
                    // const Divider(
                    //   height: 2,
                    //   color: Color(0x1A3B3B3B),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 8,
                    //     bottom: 8,
                    //     left: 10,
                    //     right: 12,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.check_circle_outline,
                    //         color: Color(0x803B3B3B),
                    //       ),
                    //       const SizedBox(width: 8),
                    //       Text(
                    //         'Verify your account',
                    //         style: GoogleFonts.nunito(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.bold,
                    //           color: const Color(0x803B3B3B),
                    //         ),
                    //       ),
                    //       const Spacer(),
                    //       const Icon(
                    //         Icons.arrow_forward_ios_rounded,
                    //         color: Color(0x803B3B3B),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
