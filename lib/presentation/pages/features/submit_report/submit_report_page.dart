import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/features/add_report/submit_report/submit_report_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/submit_report/submit_report_event.dart';
import 'package:safetrack/presentation/bloc/features/add_report/submit_report/submit_report_state.dart';
import 'package:safetrack/presentation/pages/features/submit_report/confirmation_report_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/services/feature_services.dart';
import 'package:safetrack/services/global.dart';

class SubmitReportPage extends StatelessWidget {
  final String photo;
  const SubmitReportPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final SubmitReportBloc submitReportBloc =
        SubmitReportBloc(featureServices: FeatureServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => submitReportBloc,
      child: BlocConsumer<SubmitReportBloc, SubmitReportState>(
        listener: (context, state) {
          if (state is SubmitReportSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ConfirmationReportPage(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: LightColor.backgroundColor,
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 16, top: 24, right: 16, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: LightColor.blackPrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Submit Report',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: LightColor.blackPrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(photo),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: LightColor.blackPrimaryTextColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackAccentColor,
                        ),
                        fillColor: LightColor.inputField,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        expands: true,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 12,
                            bottom: 12,
                            right: 12,
                          ),
                          hintText: 'Message',
                          hintStyle: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: LightColor.blackAccentColor,
                          ),
                          fillColor: LightColor.inputField,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      height: 2,
                      color: LightColor.dividerColor,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.add_location_alt_rounded,
                          color: LightColor.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: LightColor.blackPrimaryTextColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '#123 San Vicente, San Jacinto, Pangasinan',
                              style: GoogleFonts.quicksand(
                                fontSize: 13,
                                color: LightColor.blackSecondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: LightColor.blackPrimaryTextColor,
                        )
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<SubmitReportBloc>()
                              .add(SubmitButtonEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: LightColor.whitePrimaryTextColor,
                          ),
                        ),
                      ),
                    ),
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
