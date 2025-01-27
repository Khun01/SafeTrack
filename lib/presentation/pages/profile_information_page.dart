import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/widgets/my_profile_information.dart';
import 'package:safetrack/theme/colors.dart';

class ProfileInformationPage extends StatelessWidget {
  const ProfileInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundColor,
      body: SafeArea(
        child: Stack(
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
                                    color: Colors.black.withOpacity(0.2),
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
                              duration: const Duration(milliseconds: 500),
                              left: 0,
                              right: 0,
                              bottom: 24,
                              child: Column(
                                children: [
                                  AnimatedOpacity(
                                    opacity: scrolled ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: LightColor.whitePrimaryTextColor,
                                        borderRadius:
                                            BorderRadius.circular(500),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AnimatedOpacity(
                                    opacity: scrolled ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      'John Brandon Lambino',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.whitePrimaryTextColor,
                                      ),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    opacity: scrolled ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      'Not verified yet',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            LightColor.whiteSecondaryTextColor,
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
                                    color: LightColor.whitePrimaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 24,
                                right: 16,
                                child: AnimatedOpacity(
                                  opacity: scrolled ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: LightColor.whitePrimaryTextColor,
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                  ),
                                )),
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
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Email',
                    icon: Icons.mail_outline,
                    subheading: 'Official Email',
                    info: 'John Brandon Lambino',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Phone number',
                    icon: Icons.phone_outlined,
                    subheading: 'Mobile No.',
                    info: '(+63) 812 345 6789',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Address',
                    icon: Icons.location_on_outlined,
                    subheading: 'Official Address',
                    info: '#123, San Vicente, San Jacinto, Pangasinan',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Date of Birth',
                    icon: Icons.phone_outlined,
                    subheading: 'Your Birthdate.',
                    info: '09/09/1998',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Gender',
                    icon: Icons.cake_outlined,
                    subheading: 'Gender Identity',
                    info: 'Male',
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
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Name',
                    icon: Icons.person_2_outlined,
                    subheading: "Emergency Person's Name",
                    info: 'John Brandon Lambino',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Contact No.',
                    icon: Icons.person_2_outlined,
                    subheading: "Emergency Contact No.",
                    info: '(+63) 812 345 6789',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: MyProfileInformation(
                    title: 'Relation',
                    icon: Icons.person_2_outlined,
                    subheading: "Relationship with Contact",
                    info: 'Girlfriend',
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
      ),
    );
  }
}
