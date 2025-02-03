import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_event.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_state.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_bloc.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_state.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/pages/profile_information_page.dart';
import 'package:safetrack/presentation/pages/verify_account_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, logoutState) {
        if (logoutState is LogoutSuccessfully) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        } else if (logoutState is LogoutFailed) {
          toast(context, logoutState.error);
          log('THe error in logging out is: ${logoutState.error}');
        }
      },
      builder: (context, logoutState) {
        return Scaffold(
          backgroundColor: LightColor.backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Profile',
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<UserInformationBloc, UserInformationState>(
                        builder: (context, state) {
                          if (state is UserInformationSuccessState) {
                            final user = state.user;
                            return Row(
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.account_circle,
                                    color: LightColor.primaryColor,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackPrimaryTextColor,
                                      ),
                                    ),
                                    Text(
                                      user.isVerified == 1
                                          ? 'Verified'
                                          : 'Not verified yet',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            LightColor.blackSecondaryTextColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          } else if (state is UserInformationLoadingState) {
                            return const CircularProgressIndicator();
                          } else {
                            return const Text(
                                'Failed to load user information');
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: LightColor.dividerColor,
                          ),
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
                                  color: LightColor.blackAccentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              color: LightColor.dividerColor,
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
                                      color: LightColor.blackAccentColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Profile information',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackPrimaryTextColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: LightColor.blackAccentColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              color: LightColor.dividerColor,
                            ),
                            BlocBuilder<UserInformationBloc,
                                UserInformationState>(
                              builder: (context, state) {
                                if (state is UserInformationSuccessState) {
                                  final user = state.user;
                                  return GestureDetector(
                                    onTap: () {
                                      user.isVerified == 1 ? null : Navigator.push(
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
                                            color: LightColor.blackAccentColor,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            user.isVerified == 1 ? 'Your account is already verified' : 'Verify your account',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: LightColor
                                                  .blackPrimaryTextColor,
                                            ),
                                          ),
                                          const Spacer(),
                                          user.isVerified == 1 ? Container() : const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: LightColor.blackAccentColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }else{
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: LightColor.dividerColor,
                          ),
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
                                  color: LightColor.blackAccentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              color: LightColor.dividerColor,
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
                                    color: LightColor.blackAccentColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Notification',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.blackPrimaryTextColor,
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
                              color: LightColor.dividerColor,
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
                                      color: LightColor.blackAccentColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Logout',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackPrimaryTextColor,
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
                if (logoutState is LogoutLoading) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // ignore: deprecated_member_use
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
    );
  }
}
