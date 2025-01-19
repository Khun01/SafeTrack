import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/activities.dart';
import 'package:safetrack/presentation/cards/activities_card.dart';

class MyReportPage extends StatelessWidget {
  const MyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      Activities(
        title: 'May nag away HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
        description:
            'May nag away raw sabi ni John Brandon Lambino HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
        status: 'Completed',
        priority: 'High'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Completed',
        priority: 'Low'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'In-progress',
        priority: 'Low'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Completed',
        priority: 'High'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Completed',
        priority: 'High'
      ),
      Activities(
        title: 'May nag away HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
        description:
            'May nag away raw sabi ni John Brandon Lambino HAHAHAHAHAHAHAHAHHAHAHAHAHAHAH',
        status: 'Completed',
        priority: 'Low'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Pending',
        priority: 'Medium'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Pending',
        priority: 'High'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Completed',
        priority: 'Medium'
      ),
      Activities(
        title: 'May nag away',
        description: 'May nag away raw sabi ni John Brandon Lambino',
        status: 'Completed',
        priority: 'Low'
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'My report',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (query) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0),
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.nunito(
                      fontSize: 16, color: const Color(0x803B3B3B)),
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
                  suffixIcon:
                      const Icon(Icons.search, color: Color(0xFF3B3B3B)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return ActivitiesCard(
                    activities: activities[index],
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
        //                   style: GoogleFonts.nunito(
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
