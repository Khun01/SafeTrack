import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_state.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_state.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_bloc.dart';
import 'package:safetrack/presentation/pages/features/submit_report/camera_page.dart';
import 'package:safetrack/presentation/pages/home_page.dart';
import 'package:safetrack/presentation/pages/profile_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final CameraBloc cameraBloc = CameraBloc();
  final LogoutBloc logoutBloc =
      LogoutBloc(authServices: AuthServices(baseUrl: baseUrl));
  int selectedIndex = 0;

  Widget buildPage() {
    switch (selectedIndex) {
      case 0:
        return BlocProvider(
          create: (context) => UserGuideBloc(),
          child: const HomePage(),
        );
      case 1:
        return const SizedBox.shrink();

      case 2:
        return BlocProvider(
          create: (context) => logoutBloc,
          child: const ProfilePage(),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cameraBloc,
        ),
        BlocProvider(
          create: (context) => logoutBloc,
        ),
      ],
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, logoutState) {},
        builder: (context, logoutState) {
          return BlocConsumer<CameraBloc, CameraState>(
            listener: (context, cameraState) {},
            builder: (context, cameraState) {
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
                            showUnselectedLabels: false,
                            iconSize: 28,
                            selectedItemColor: LightColor.primaryColor,
                            selectedLabelStyle: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: LightColor.primaryColor,
                            ),
                            unselectedLabelStyle: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: LightColor.blackPrimaryTextColor,
                            ),
                            unselectedItemColor:
                                LightColor.blackPrimaryTextColor,
                            items: [
                              BottomNavigationBarItem(
                                label: 'Home',
                                icon: Icon(
                                  selectedIndex == 0
                                      ? Icons.home
                                      : Icons.home_outlined,
                                ),
                              ),
                              const BottomNavigationBarItem(
                                  label: '', icon: SizedBox.shrink()),
                              BottomNavigationBarItem(
                                label: "Profile",
                                icon: Icon(
                                  selectedIndex == 2
                                      ? Icons.person
                                      : Icons.person_outline,
                                ),
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
                      if (logoutState is LogoutLoading) ...[
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
          );
        },
      ),
    );
  }
}
