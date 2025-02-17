import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/my_report.dart';
import 'package:safetrack/presentation/cards/my_report_card.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';

class MyReportPage extends StatelessWidget {
  const MyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myReport = [
      MyReport(
          title: 'May nag away HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
          description:
              'May nag away raw sabi ni John Brandon Lambino HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
          location: 'Dito lang samin',
          status: 'Completed',
          priority: 'High',
          date: 'August 10, 2024,'),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Completed',
        priority: 'Low',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Investigating',
        priority: 'Low',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Completed',
        priority: 'High',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Completed',
        priority: 'High',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
        description:
            'May nag away raw sabi ni John Brandon Lambino HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
        location: 'Dito lang samin',
        status: 'Investigating',
        priority: 'Low',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Pending',
        priority: 'Medium',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Pending',
        priority: 'High',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Completed',
        priority: 'Medium',
        date: 'August 10, 2024',
      ),
      MyReport(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        location: 'Dito lang samin',
        status: 'Investigating',
        priority: 'Low',
        date: 'August 10, 2024',
      ),
    ];
    return Scaffold(
      backgroundColor: LightColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: MyHeader(title: 'My report'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (query) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: LightColor.inputField,
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: LightColor.blackSecondaryTextColor,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: LightColor.blackSecondaryTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: myReport.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                      left: 16,
                      right: 16,
                    ),
                    child: MyReportCard(
                      myReport: myReport[index],
                    ),
                  );
                },
              ),
            )
          ],
        ),
        // child: CustomScrollView(
        //   slivers: [
        // SliverLayoutBuilder(
        //   builder: (context, constraints) {
        //     final scrolled = constraints.scrollOffset > 0;
        //     return SliverAppBar(
        //       pinned: true,
        //       automaticallyImplyLeading: false,
        //       collapsedHeight: 70,
        //       flexibleSpace: AnimatedContainer(
        //         duration: const Duration(milliseconds: 300),
        //         padding: const EdgeInsets.only(left: 16, right: 16),
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).scaffoldBackgroundColor,
        //           boxShadow: scrolled
        //               ? [
        //                   BoxShadow(
        //                       color: Colors.black.withOpacity(0.1),
        //                       offset: const Offset(0.0, 10.0),
        //                       blurRadius: 10.0,
        //                       spreadRadius: -6.0)
        //                 ]
        //               : [],
        //         ),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: GestureDetector(
        //                   onTap: (){
        //                     Navigator.pop(context);
        //                   },
        //                   child: const Icon(Icons.arrow_back_ios),
        //                 ),
        //               ),
        //             ),
        //             Expanded(
        //               child: Center(
        //                 child: Text(
        //                   'My Report',
        //                   style: GoogleFonts.quicksand(
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.bold,
        //                     color: const Color(0xFF3B3B3B),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Expanded(
        //               child: Container(),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),

        // SliverList.builder(
        //   itemBuilder: (context, index) {
        //     return ActivitiesCard(
        //       activities: activities[index],
        //     );
        //   },
        //   itemCount: activities.length,
        // ),
        // const SliverToBoxAdapter(
        //   child: SizedBox(height: 16),
        // )

        //   ],
        // ),
      ),
    );
  }
}
