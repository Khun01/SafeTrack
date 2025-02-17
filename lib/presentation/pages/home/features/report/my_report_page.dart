import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_event.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_state.dart';
import 'package:safetrack/presentation/cards/my_report_card.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';
import 'package:safetrack/services/feature_services.dart';
import 'package:safetrack/services/global.dart';

class MyReportPage extends StatelessWidget {
  const MyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final MyReportBloc myReportBloc =
        MyReportBloc(featureServices: FeatureServices(baseUrl: baseUrl))
          ..add(FetchingMyReportEvent());

    final TextEditingController searchController = TextEditingController();

    return BlocProvider(
      create: (context) => myReportBloc,
      child: BlocConsumer<MyReportBloc, MyReportState>(
        listener: (context, state) {},
        builder: (context, state) {
          Widget body;
          switch (state) {
            case FetchingMyReportState():
              body = const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                    child: CircularProgressIndicator(
                  color: LightColor.primaryColor,
                )),
              );
              break;
            case FetchingMyReportSuccessState():
              final myReport = state.myReport.toList();
              final searchQuery = searchController.text.toLowerCase();
              final filteredReports = myReport
                  .where((report) =>
                      report.location.toLowerCase().contains(searchQuery) ||
                      report.description.toLowerCase().contains(searchQuery) ||
                      report.status.toLowerCase().contains(searchQuery) ||
                      report.priority.toLowerCase().contains(searchQuery) ||
                      report.date.toLowerCase().contains(searchQuery))
                  .toList();
              if (filteredReports.isEmpty) {
                body = SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      searchQuery.isEmpty
                          ? 'No events scheduled for this day'
                          : 'Nothing found for "$searchQuery"',
                      style: GoogleFonts.quicksand(
                        color: LightColor.blackSecondaryTextColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              } else {
                body = LiveSliverList(
                  controller: scrollController,
                  itemCount: filteredReports.length,
                  itemBuilder: (context, index, animation) {
                    final myReports = filteredReports[index];
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 0,
                        end: 1,
                      ).animate(animation),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MyReportCard(myReport: myReports),
                        ),
                      ),
                    );
                  },
                );
              }
              break;
            case FetchingMyReportErrorState():
              body = SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    state.errorMessage,
                    style: GoogleFonts.quicksand(
                      color: LightColor.blackSecondaryTextColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
              break;
            default:
              body = SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'Network Error',
                    style: GoogleFonts.quicksand(
                      color: LightColor.blackSecondaryTextColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
              break;
          }
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<MyReportBloc>().add(FetchingMyReportEvent());
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
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextField(
                                      controller: searchController,
                                      onChanged: (query) {
                                        context.read<MyReportBloc>().add(
                                            SearchMyReportEvent(query: query));
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: LightColor.inputField,
                                        hintText: 'Search...',
                                        hintStyle: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: LightColor.blackAccentColor,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color: LightColor
                                              .blackSecondaryTextColor,
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
                    body,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
