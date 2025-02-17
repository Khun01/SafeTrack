import 'dart:developer';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:safetrack/models/events/event.dart';
import 'package:safetrack/presentation/bloc/features/get_events/get_events_bloc.dart';
import 'package:safetrack/presentation/bloc/features/get_events/get_events_event.dart';
import 'package:safetrack/presentation/bloc/features/get_events/get_events_state.dart';
import 'package:safetrack/presentation/cards/event_card.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';
import 'package:safetrack/services/feature_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GetEventsBloc getEventsBloc =
      GetEventsBloc(featureServices: FeatureServices(baseUrl: baseUrl))
        ..add(GetEvents());

  final scrollController = ScrollController();

  String formattedDate = DateFormat('MMMM yyyy').format(DateTime.now());
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  List<Event> getEventsForDay(BuildContext context, DateTime day) {
    final state = context.watch<GetEventsBloc>().state;
    if (state is GetEventsSuccessState) {
      final events = state.event ?? [];
      return events
          .where((event) => isSameDay(DateTime.tryParse(event.date ?? ''), day))
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getEventsBloc,
      child: BlocConsumer<GetEventsBloc, GetEventsState>(
        listener: (context, getEventState) {},
        builder: (context, getEventState) {
          Widget body;
          switch (getEventState) {
            case GetEventsLoadingState():
              body = const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case GetEventsSuccessState():
              final events = getEventState.event
                      ?.where((getEventState) => isSameDay(
                          DateTime.tryParse(getEventState.date ?? ''),
                          selectedDay))
                      .toList() ??
                  [];
              if (events.isEmpty) {
                body = SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No events scheduled for this day',
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
                  itemCount: events.length,
                  itemBuilder: (context, index, animation) {
                    bool isExpanded = getEventState.expandedIndex == index;
                    log('Current expandedIndex in state: $isExpanded');
                    final event = events[index];
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<GetEventsBloc>()
                            .add(ToggleExpansionEvent(index));
                      },
                      child: FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: EventCard(
                            title: event.title,
                            description: event.description ?? '',
                            color: event.color,
                            firstStartTime: event.formattedStartTime,
                            lastEndTime: event.formattedEndTime,
                            schedule: event.schedule ?? [],
                            isExpanded: isExpanded,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              break;
            case GetEventsFailedState():
              body = SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'Failed to load events',
                    style: GoogleFonts.quicksand(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
              break;
            default:
              body = const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              );
              break;
          }
          return Scaffold(
            backgroundColor: LightColor.backgroundColor,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  getEventsBloc.add(GetEvents());
                },
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyHeader(title: 'Calendar'),
                            Text(
                              formattedDate,
                              style: GoogleFonts.quicksand(
                                color: LightColor.blackSecondaryTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            buildCalendar(),
                            const SizedBox(height: 16),
                            Text(
                              "Today's event",
                              style: GoogleFonts.quicksand(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: LightColor.blackPrimaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: Divider(
                          height: 2,
                          color: LightColor.accentColor,
                        ),
                      ),
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

  Widget buildCalendar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: LightColor.accentColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A023E8A),
            offset: Offset(0.0, 10.0),
            blurRadius: 4.0,
            spreadRadius: -4.0,
          )
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDay,
        calendarFormat: CalendarFormat.week,
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        headerVisible: false,
        calendarStyle: CalendarStyle(
          tablePadding: const EdgeInsets.only(bottom: 12),
          defaultTextStyle: GoogleFonts.quicksand(
            color: LightColor.blackPrimaryTextColor,
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: GoogleFonts.quicksand(
            color: LightColor.blackPrimaryTextColor,
            fontWeight: FontWeight.bold,
          ),
          weekendDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          defaultDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          todayDecoration: BoxDecoration(
            color: LightColor.accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
          todayTextStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: LightColor.blackPrimaryTextColor,
          ),
          selectedDecoration: BoxDecoration(
            color: LightColor.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: LightColor.blackAccentColor,
          ),
          weekendStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: LightColor.blackAccentColor,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            final eventList = getEventsForDay(context, day);
            if (eventList.isNotEmpty) {
              return Positioned(
                bottom: -6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    eventList.length > 3 ? 3 : eventList.length,
                    (index) => Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: eventList[index].color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            }
            return null;
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
          log("Selected Date: $selectedDay");
        },
      ),
    );
  }
}
