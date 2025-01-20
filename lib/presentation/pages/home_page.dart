import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/announcement.dart';
import 'package:safetrack/presentation/cards/announcement_card.dart';
import 'package:safetrack/presentation/pages/features/calendar_page.dart';
import 'package:safetrack/presentation/pages/features/contacts_page.dart';
import 'package:safetrack/presentation/pages/features/educational_page.dart';
import 'package:safetrack/presentation/pages/features/my_report_page.dart';
import 'package:safetrack/presentation/pages/features/safety_map_page.dart';
import 'package:safetrack/presentation/widgets/my_app_bar.dart';
import 'package:safetrack/presentation/widgets/my_home_page_feature_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: MyAppBar(),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 2,
                color: Color(0xFFC2C2C2),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  'Announcement',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
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
                            name: 'My Report',
                            image: 'assets/icons/document.png',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyReportPage()));
                            },
                          ),
                          const SizedBox(height: 24),
                          MyHomePageFeatureButton(
                            name: 'Educational',
                            image: 'assets/icons/educational.png',
                            onTap: () {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EducationalPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          MyHomePageFeatureButton(
                            name: 'Safety Map',
                            image: 'assets/icons/map.png',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SafetyMapPage()));
                            },
                          ),
                          const SizedBox(height: 24),
                          MyHomePageFeatureButton(
                            name: 'Contacts',
                            image: 'assets/icons/contact.png',
                            onTap: () {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ContactsPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          MyHomePageFeatureButton(
                            name: 'Calendar',
                            image: 'assets/icons/calendar.png',
                            onTap: () {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CalendarPage()));
                            },
                          ),
                          const SizedBox(height: 24),
                          MyHomePageFeatureButton(
                            name: 'SOS',
                            image: 'assets/icons/sos.png',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('SOS')));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
                child: Text(
                  'Safety Tips',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B),
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
            const SliverToBoxAdapter(
              child: SizedBox(height: 66),
            )
          ],
        ),
      ),
    );
  }
}
