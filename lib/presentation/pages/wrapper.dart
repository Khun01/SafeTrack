// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_state.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_state.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_bloc.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_event.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_state.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_bloc.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_state.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_bloc.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_event.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_state.dart';
import 'package:safetrack/presentation/pages/home/features/submit_report/camera_page.dart';
import 'package:safetrack/presentation/pages/home/home_page.dart';
import 'package:safetrack/presentation/pages/profile/profile_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/feature_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/services/profile_services.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with SingleTickerProviderStateMixin {
  final CameraBloc cameraBloc = CameraBloc();
  final UserGuideBloc userGuideBloc = UserGuideBloc();
  final LogoutBloc logoutBloc =
      LogoutBloc(authServices: AuthServices(baseUrl: baseUrl));
  final UserInformationBloc userInformationBloc =
      UserInformationBloc(profileServices: ProfileServices(baseUrl: baseUrl))
        ..add(GetUserEvent());
  final AnnouncementBloc announcementBloc =
      AnnouncementBloc(featureServices: FeatureServices(baseUrl: baseUrl))
        ..add(FetchAnnouncementEvent());
  int selectedIndex = 0;

  late final AnimationController controller;
  bool animationFinished = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage() {
    switch (selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const SizedBox.shrink();
      case 2:
        return const ProfilePage();
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
        BlocProvider(
          create: (context) => userInformationBloc,
        ),
        BlocProvider(
          create: (context) => userGuideBloc,
        ),
        BlocProvider(
          create: (context) => announcementBloc,
        )
      ],
      child: BlocConsumer<AnnouncementBloc, AnnouncementState>(
        listener: (context, announcementState) {},
        builder: (context, announcementState) {
          return BlocConsumer<UserGuideBloc, UserGuideState>(
            listener: (context, userGuideState) {
              if (userGuideState is UserGuideFinishedState) {
                showGeneralDialog(
                  context: context,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  transitionDuration: const Duration(seconds: 1),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return StatefulBuilder(builder: (context, setModalState) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                        child: FadeTransition(
                          opacity: animation,
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset(
                                    'assets/lottie/user_guide_finished.json',
                                    height: 250,
                                    controller: controller,
                                    onLoaded: (composition) {
                                      controller
                                        ..duration = composition.duration
                                        ..forward();
                                      controller.addStatusListener((status) {
                                        if (status ==
                                            AnimationStatus.completed) {
                                          setModalState(() {
                                            animationFinished = true;
                                          });
                                        }
                                      });
                                    },
                                    repeat: false,
                                  ),
                                  const SizedBox(height: 16),
                                  AnimatedOpacity(
                                    opacity: animationFinished ? 1 : 0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      'Congratulations!',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.blackPrimaryTextColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AnimatedOpacity(
                                    opacity: animationFinished ? 1 : 0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      "You're all set! SafeTrack is ready to help you report incidents in your barangay quickly and easily. Stay safe, and let's work together to keep our community secure!",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            LightColor.blackSecondaryTextColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: AnimatedOpacity(
                                      opacity: animationFinished ? 1 : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              LightColor.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Text(
                                          'Confirm',
                                          style: GoogleFonts.quicksand(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: LightColor
                                                .whitePrimaryTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                );
              }
            },
            builder: (context, userGuideState) {
              return BlocConsumer<UserInformationBloc, UserInformationState>(
                listener: (context, userInformationState) {},
                builder: (context, userInformationState) {
                  return BlocConsumer<LogoutBloc, LogoutState>(
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
                                    child: SizedBox(
                                      height: 60,
                                      child: BottomNavigationBar(
                                        elevation: 0,
                                        showUnselectedLabels: false,
                                        iconSize: 28,
                                        selectedItemColor:
                                            LightColor.primaryColor,
                                        selectedLabelStyle:
                                            GoogleFonts.quicksand(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: LightColor.primaryColor,
                                        ),
                                        unselectedLabelStyle:
                                            GoogleFonts.quicksand(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              LightColor.blackPrimaryTextColor,
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
                                            label: '',
                                            icon: SizedBox.shrink(),
                                          ),
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
                                            builder: (context) =>
                                                BlocProvider.value(
                                              value: cameraBloc,
                                              child: const CameraPage(),
                                            ),
                                          ),
                                        );
                                        context
                                            .read<CameraBloc>()
                                            .add(InitializeCameraEvent());
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: LightColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 32,
                                            color: LightColor
                                                .whitePrimaryTextColor,
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
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
