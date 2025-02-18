// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_bloc.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_event.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_state.dart';
import 'package:safetrack/presentation/widgets/my_profile_information.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/services/profile_services.dart';

class ProfileInformationPage extends StatelessWidget {
  const ProfileInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserInformationBloc userInformationBloc =
        UserInformationBloc(profileServices: ProfileServices(baseUrl: baseUrl))
          ..add(GetUserEvent());
    return BlocProvider(
      create: (context) => userInformationBloc,
      child: BlocConsumer<UserInformationBloc, UserInformationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserInformationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserInformationSuccessState) {
            final user = state.user;
            return Scaffold(
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverLayoutBuilder(
                        builder: (BuildContext context, constraints) {
                          final scrolled = constraints.scrollOffset > 50;
                          return SliverAppBar(
                            pinned: true,
                            automaticallyImplyLeading: false,
                            expandedHeight: 250,
                            collapsedHeight: 76,
                            flexibleSpace: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 250,
                              decoration: BoxDecoration(
                                color: LightColor.primaryColor,
                                boxShadow: scrolled
                                    ? [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.2),
                                          offset: const Offset(0.0, 10.0),
                                          blurRadius: 10.0,
                                          spreadRadius: -6.0,
                                        )
                                      ]
                                    : [],
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  AnimatedPositioned(
                                    duration:
                                        const Duration(milliseconds: 500),
                                    left: 0,
                                    right: 0,
                                    bottom: 24,
                                    child: Column(
                                      children: [
                                        AnimatedOpacity(
                                          opacity: scrolled ? 0 : 1,
                                          duration: const Duration(
                                              milliseconds: 300),
                                          child: const Center(
                                            child: Icon(
                                              Icons.account_circle,
                                              color: LightColor
                                                  .whitePrimaryTextColor,
                                              size: 110,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        AnimatedOpacity(
                                          opacity: scrolled ? 0 : 1,
                                          duration: const Duration(
                                              milliseconds: 300),
                                          child: Text(
                                            user.name,
                                            style: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: LightColor
                                                  .whitePrimaryTextColor,
                                            ),
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          opacity: scrolled ? 0 : 1,
                                          duration: const Duration(
                                              milliseconds: 300),
                                          child: Text(
                                            user.isVerified == 1
                                                ? 'Verified'
                                                : 'Not verified yet',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: LightColor
                                                  .whiteSecondaryTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 24,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        'Profile information',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: LightColor
                                              .whitePrimaryTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 24,
                                    right: 16,
                                    child: AnimatedOpacity(
                                      opacity: scrolled ? 1 : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const Center(
                                        child: Icon(
                                          Icons.account_circle,
                                          color: LightColor
                                              .whitePrimaryTextColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                          ),
                          child: Text(
                            'Basic Information',
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: LightColor.blackPrimaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                            title: 'Email',
                            icon: Icons.mail_outline,
                            subheading: 'Official Email',
                            info: user.email),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Phone number',
                          icon: Icons.phone_outlined,
                          subheading: 'Mobile No.',
                          info: user.phoneNumber ?? 'Your phone number',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Address',
                          icon: Icons.location_on_outlined,
                          subheading: 'Official Address',
                          info: user.address ?? 'Your address',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Date of Birth',
                          icon: Icons.phone_outlined,
                          subheading: 'Your Birthdate.',
                          info: user.dateOfBirth ?? 'Your birthday',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Gender',
                          icon: Icons.cake_outlined,
                          subheading: 'Gender Identity',
                          info: user.gender ?? 'Your gender',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                          ),
                          child: Text(
                            'Emergency Contact',
                            style: GoogleFonts.quicksand(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: LightColor.blackPrimaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Name',
                          icon: Icons.person_2_outlined,
                          subheading: "Emergency Person's Name",
                          info: user.emergencyContactName ??
                              "Your ermergencey person's name",
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Contact No.',
                          icon: Icons.person_2_outlined,
                          subheading: "Emergency Contact No.",
                          info: user.emergencyContactNumber ??
                              'Your ermergencey person contact number',
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: MyProfileInformation(
                          title: 'Relation',
                          icon: Icons.person_2_outlined,
                          subheading: "Relationship with Contact",
                          info: user.relationship ??
                              'Relationship to your emergencey contact person',
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 24),
                      )
                    ],
                  ),
                  Positioned(
                    top: 24,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: LightColor.whitePrimaryTextColor,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is UserInformationFailedState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: GoogleFonts.quicksand(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: LightColor.whitePrimaryTextColor,
                ),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: LightColor.primaryColor,
              child: Center(
                child: Text(
                  'Ngek error',
                  style: GoogleFonts.quicksand(fontSize: 48),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
