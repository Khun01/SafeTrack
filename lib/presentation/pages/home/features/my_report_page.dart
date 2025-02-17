import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';

class MyReportPage extends StatelessWidget {
  const MyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            return;
          },
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverLayoutBuilder(
                builder: (BuildContext context, constraints) {
                  final scrolled = constraints.scrollOffset > 50;
                  return SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    expandedHeight: 130,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    scrolledUnderElevation: 0,
                    title: const MyHeader(title: 'My report'),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          const SizedBox(height: 68),
                          AnimatedOpacity(
                            opacity: scrolled ? 0 : 1,
                            duration: const Duration(milliseconds: 300),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                onChanged: (query) {},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: LightColor.inputField,
                                  hintText: 'Search...',
                                  hintStyle: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: LightColor.blackAccentColor,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1500,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
