import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_bloc.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_bloc.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_event.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_state.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_bloc.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_state.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_bloc.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_event.dart';
import 'package:safetrack/presentation/pages/home/features/report/camera_page.dart';
import 'package:safetrack/presentation/pages/home/home_page.dart';
import 'package:safetrack/presentation/pages/profile/profile_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';
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

  int currentIndex = 0;

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.person_outline,
  ];

  final activeIconList = <IconData>[
    Icons.home,
    Icons.person,
  ];

  Widget buildPage() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
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
      child: BlocConsumer<UserGuideBloc, UserGuideState>(
        listener: (context, userGuideState) {
          if (userGuideState is UserGuideFinishedState) {
            showGeneralDialog(
              context: context,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
                                    if (status == AnimationStatus.completed) {
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
                                    color: LightColor.blackSecondaryTextColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: AnimatedOpacity(
                                  opacity: animationFinished ? 1 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: LightColor.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      'Confirm',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: LightColor.whitePrimaryTextColor,
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
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: buildPage(),
            floatingActionButton: BlocBuilder<CameraBloc, CameraState>(
              builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: cameraBloc,
                          child: const CameraPage(),
                        ),
                      ),
                    );
                    context.read<CameraBloc>().add(InitializeCameraEvent());
                  },
                  shape: const CircleBorder(),
                  backgroundColor: LightColor.primaryColor,
                  hoverColor: Colors.red,
                  child: const Icon(
                    Icons.add,
                    color: LightColor.whitePrimaryTextColor,
                  ),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: iconList.length,
              tabBuilder: (int index, bool isActive) {
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Icon(
                        isActive ? activeIconList[index] : iconList[index],
                        size: 28,
                        color: isActive
                            ? LightColor.primaryColor
                            : LightColor.blackPrimaryTextColor,
                      ),
                    ),
                    isActive ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 5,
                          width: 64,
                          decoration: const BoxDecoration(
                            color: LightColor.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)
                            )
                          ),
                        ),
                      ),
                    ) : const SizedBox.shrink()
                  ],
                );
              },
              activeIndex: currentIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              backgroundColor: LightColor.whitePrimaryTextColor,
              elevation: 10,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
