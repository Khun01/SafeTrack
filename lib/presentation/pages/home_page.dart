import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/announcement.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_bloc.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_event.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_state.dart';
import 'package:safetrack/presentation/cards/announcement_card.dart';
import 'package:safetrack/presentation/pages/features/calendar_page.dart';
import 'package:safetrack/presentation/pages/features/contacts_page.dart';
import 'package:safetrack/presentation/pages/features/educational_page.dart';
import 'package:safetrack/presentation/pages/features/my_report_page.dart';
import 'package:safetrack/presentation/pages/features/safety_map_page.dart';
import 'package:safetrack/presentation/widgets/my_app_bar.dart';
import 'package:safetrack/presentation/widgets/my_home_page_feature_button.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_tutorial_coach_mark.dart';
import 'package:safetrack/services/global.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey announcementKey = GlobalKey();
  GlobalKey safetyTips = GlobalKey();
  GlobalKey myReport = GlobalKey();
  GlobalKey safetyMap = GlobalKey();
  GlobalKey calendar = GlobalKey();
  GlobalKey educational = GlobalKey();
  GlobalKey contacts = GlobalKey();
  GlobalKey sos = GlobalKey();

  GlobalKey addReport = GlobalKey();
  GlobalKey home = GlobalKey();
  GlobalKey profile = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<UserGuideBloc>().add(UserGuideStatus());
  }

  @override
  Widget build(BuildContext context) {
    final announcement = [
      Announcement(
        title: 'Barangay Fiesta 2025',
        description:
            'Join us for a day of fun, food, and festivities to celebrate the annual Barangay Fiesta.',
        date: '2025-02-15',
      ),
      Announcement(
        title: 'Clean-Up Drive',
        description:
            'Help keep our barangay clean! Join the community clean-up drive and make a difference.',
        date: '2025-01-20',
      ),
      Announcement(
        title: 'Barangay Health Awareness Seminar',
        description:
            'Learn more about health and wellness at our free health awareness seminar hosted by the barangay health center.',
        date: '2025-01-25',
      ),
      Announcement(
        title: 'Christmas Gift-Giving',
        description:
            'Spread the holiday cheer by joining our annual Christmas gift-giving event for less fortunate families in our barangay.',
        date: '2025-12-15',
      ),
      Announcement(
        title: 'Sports Festival 2025',
        description:
            'Get ready for a fun and competitive sports festival in our barangay. All residents are welcome to participate!',
        date: '2025-03-10',
      ),
    ];

    return BlocConsumer<UserGuideBloc, UserGuideState>(
      listener: (context, state) {
        if (state is UserGuideHasSeenState) {       
          log('Wow grape nakita mo na ang user guide namin!!!');
        } else if (state is UserGuideFinishedState) {
          log('The state is finished');
        } else if (state is UserGuideHasntSeenState) {
          createTutorial();
          Future.delayed(const Duration(seconds: 1), showTutorial);
        }
      },
      builder: (context, state) {
        //pang reset lang
        // if (state is UserGuideHasSeenState) {
        //   context.read<UserGuideBloc>().add(UserGuideResetEvent());
        // }
        return Scaffold(
          backgroundColor: LightColor.backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: MyAppBar(),
                    ),
                    const SliverToBoxAdapter(
                      child: Divider(height: 2, color: LightColor.dividerColor),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            key: announcementKey,
                            'Announcement',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: LightColor.blackPrimaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 240,
                        padding: const EdgeInsets.only(right: 16),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: announcement.length,
                          itemBuilder: (context, index) {
                            return AnnouncementCard(
                              announcement: announcement[index],
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        color: const Color(0x4DE5E9F4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  MyHomePageFeatureButton(
                                    key: myReport,
                                    name: 'My Report',
                                    image: 'assets/icons/document.png',
                                    onTap: const MyReportPage(),
                                  ),
                                  const SizedBox(height: 24),
                                  MyHomePageFeatureButton(
                                    key: educational,
                                    name: 'Educational',
                                    image: 'assets/icons/educational.png',
                                    onTap: const EducationalPage(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  MyHomePageFeatureButton(
                                    key: safetyMap,
                                    name: 'Safety Map',
                                    image: 'assets/icons/map.png',
                                    onTap: const SafetyMapPage(),
                                  ),
                                  const SizedBox(height: 24),
                                  MyHomePageFeatureButton(
                                    key: contacts,
                                    name: 'Contacts',
                                    image: 'assets/icons/contact.png',
                                    onTap: const ContactsPage(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  MyHomePageFeatureButton(
                                    key: calendar,
                                    name: 'Calendar',
                                    image: 'assets/icons/calendar.png',
                                    onTap: const CalendarPage(),
                                  ),
                                  const SizedBox(height: 24),
                                  GestureDetector(
                                    onTap: () {
                                      toast(context, "SOS");
                                    },
                                    child: Column(
                                      key: sos,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: const Color(0xFFE5E9F4),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x1A023E8A),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                              )
                                            ],
                                          ),
                                          child: Image.asset(
                                              'assets/icons/sos.png'),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'SOS',
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: LightColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          bottom: 8,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            key: safetyTips,
                            'Safety Tips',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: LightColor.blackPrimaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SliverList.builder(
                    //   itemBuilder: (context, index) {
                    //     return ActivitiesCard(
                    //       activities: activities[index],
                    //     );
                    //   },
                    //   itemCount: activities.length,
                    // ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 80,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          key: home,
                          height: 60,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          key: addReport,
                          height: 60,
                          color: Colors.amber,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          key: profile,
                          height: 60,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: LightColor.blackPrimaryTextColor,
      hideSkip: true,
      pulseEnable: false,
      opacityShadow: 0.4,
      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      onFinish: () {
        context.read<UserGuideBloc>().add(UserGuideCompleteEvent());
        log("finish");
      },
      onSkip: () {
        log("skip");
        context.read<UserGuideBloc>().add(UserGuideCompleteEvent());
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "announcementKey",
        keyTarget: announcementKey,
        shape: ShapeLightFocus.RRect,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Announcement',
                text:
                    "Stay up to date with the latest announcements, including upcoming community events, health seminars, celebrations, and volunteer opportunities in our barangay.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "myReport",
        keyTarget: myReport,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'My Report',
                text:
                    "Here you can view and manage all the reports you've submitted. Stay updated on the status of your reports and track your community's safety.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "safetyMap",
        keyTarget: safetyMap,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Safety Map',
                text:
                    "The Safety Map shows real-time incidents happening around your community. Use this map to stay informed and take necessary actions when needed.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "calendar",
        keyTarget: calendar,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Calendar',
                text:
                    "Use the calendar to keep track of important community events and updates. Stay informed on safety-related activities and deadlines.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "educational",
        keyTarget: educational,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Educational',
                text:
                    "Access educational resources and safety tips to learn more about community safety, emergency protocols, and how you can contribute to a safer environment.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "contacts",
        keyTarget: contacts,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Contacts',
                text:
                    "Quick access to important contacts for emergencies or community support. Reach out to local authorities or safety teams directly when needed.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "sos",
        keyTarget: sos,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'SOS',
                text:
                    "In case of an emergency, use the SOS feature to quickly send alerts and request help from community responders or local authorities.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "safetyTips",
        keyTarget: safetyTips,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Safety Tips',
                text:
                    "Get essential safety tips and guidelines to help you stay prepared and protect yourself and your community during emergencies, natural disasters, and everyday situations.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "home",
        keyTarget: home,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Home',
                text:
                    "Stay updated with the latest events, incidents, and updates happening in your area. Use this page as your gateway to explore community safety and resources.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "profile",
        keyTarget: profile,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Profile',
                text:
                    "View and update your personal information, manage your preferences, and ensure your account is always up to date for a personalized experience.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "addReport",
        keyTarget: addReport,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return MyTutorialCoachMark(
                title: 'Report Incidents',
                text:
                    "Report any incidents or safety concerns in your community. Use this feature to share details about incidents and contribute to improving safety in your area.",
                next: "Finish",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }
}
