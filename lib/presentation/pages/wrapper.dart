import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_state.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_bloc.dart';
import 'package:safetrack/presentation/pages/features/submit_report/camera_page.dart';
import 'package:safetrack/presentation/pages/home_page.dart';
import 'package:safetrack/presentation/pages/profile_page.dart';
import 'package:safetrack/theme/colors.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;

  Widget buildPage() {
    switch (selectedIndex) {
      case 0:
        return BlocProvider(
          create: (context) => UserGuideBloc(),
          child: const HomePage(),
        );
      case 1:
        return const ProfilePage();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final CameraBloc cameraBloc = CameraBloc();
    return BlocProvider(
      create: (context) => cameraBloc,
      child: BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  buildPage(),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, -6),
                        ),
                      ]),
                      child: BottomNavigationBar(
                        selectedItemColor: LightColor.primaryColor,
                        selectedLabelStyle: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: LightColor.primaryColor,
                        ),
                        unselectedLabelStyle: GoogleFonts.quicksand(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                        unselectedItemColor: LightColor.blackPrimaryTextColor,
                        items: [
                          BottomNavigationBarItem(
                            label: 'Home',
                            icon: selectedIndex == 0
                                ? const Icon(Icons.home)
                                : const Icon(Icons.home_outlined),
                          ),
                          BottomNavigationBarItem(
                            label: "Profile",
                            icon: selectedIndex == 1
                                ? const Icon(Icons.person)
                                : const Icon(Icons.person_outline),
                          ),
                        ],
                        currentIndex: selectedIndex,
                        onTap: (int index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: cameraBloc,
                              child: const CameraPage(),
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: LightColor.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 32,
                            color: LightColor.whitePrimaryTextColor,
                          ),
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
    );
  }
}
